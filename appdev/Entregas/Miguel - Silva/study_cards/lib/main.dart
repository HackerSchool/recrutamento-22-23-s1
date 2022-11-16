import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_column_content/main_column.dart';
import './the_cards.dart';
import 'popup_messages/create_card/create_card_menu.dart';
import './splash_screen.dart';
import './help_page.dart';

void main() {
  runApp(const MyApp());
}

class CardStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    final exdirectory = await getExternalStorageDirectory();

    //print(directory);

    return (exdirectory == null) ? directory.path : exdirectory.path;
    //return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/cards.txt');
  }

  Future<String> readCards() async {
    try {
      final file = await _localFile;

      // Read the file
      final cardContent = await file.readAsString();

      return cardContent;
    } catch (e) {
      // If encountering an error, return "0"
      return "0";
    }
  }

  Future<File> writeCards(String cardsJSON) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(cardsJSON);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Cards',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          cardColor: Colors.deepPurple[50],
        ),
        scaffoldBackgroundColor: Colors.deepPurple[50],
      ),
      home: AnimatedSplashScreen(
        splashIconSize: 500,
        duration: 500, //duration: 2000,
        backgroundColor: Colors.deepPurple[50] as Color,
        splash: Splash(key: key, backgroundColor: Colors.deepPurple[50]),
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});
  final String title = "My Study Cards";
  final CardStorage cardStorage = CardStorage();
  TheCards theCards = TheCards(resetMap: true);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var createCardMenu = CreateCardMenu();
  bool onlyFavorites = false;
  bool _beginnerState = true;

  Future<void> addCard({required String question, required String answer, required bool favorite}) {
    setState(() {
      widget.theCards.add(question: question, answer: answer, favorite: favorite);
    });
    // Write the variable as a string to the file.
    //print("\n\n- add cards>");
    //print(widget.theCards.cardQnA.length);
    return widget.cardStorage.writeCards(jsonEncode(widget.theCards.cardQnA));
  }

  Future<void> deleteCards(int index) {
    // Write the variable as a string to the file.
    //print("\n\n- delete card>");
    //print(widget.theCards.cardQnA.length);
    widget.theCards.cardQnA.removeAt(index);
    return widget.cardStorage.writeCards(jsonEncode(widget.theCards.cardQnA));
  }

  Future<void> editOrOrderCard({int? index, String? question, String? answer, bool? favorite}) {
    setState(() {
      if (index != null) {
        question != null ? widget.theCards.cardQnA[index]["question"] = question : {};
        answer != null ? widget.theCards.cardQnA[index]["answer"] = answer : {};
        favorite != null ? widget.theCards.cardQnA[index]["favorite"] = favorite : {};
      }
    });
    // Write the variable as a string to the file.
    //print("\n\n- edit or order cards>");
    //print(widget.theCards.cardQnA);
    return widget.cardStorage.writeCards(jsonEncode(widget.theCards.cardQnA));
  }

  Future<void> _loadBeginnerState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _beginnerState = (prefs.getBool('beginnerState') ?? true);
    });
  }

  Future<void> _saveBeginnerState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('beginnerState', false);
    });
  }

  @override
  void initState() {
    super.initState();

    widget.cardStorage.readCards().then((rawJSON) {
      setState(() {
        widget.theCards.loadParsedJson(jsonDecode(rawJSON));
        //print("after Decode MAIN APP--->");
        //print(widget.theCards);
      });
    });

    _pushHelpPageHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title),
            IconButton(
              icon: const Icon(Icons.list), //menu_rounded
              onPressed: _pushFavorites,
            ),
          ],
        ),
      ),
      body: MainColumn(
        theCards: widget.theCards,
        editOrOrderCard: editOrOrderCard,
        deleteCards: deleteCards,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => createCardMenu.createCardMenu(context, addCard)), // (() => createCardMenu.createCardMenu(context, addCard)),
        tooltip: 'Add Card',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _pushFavorites() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext) {
          TheCards favoriteCards = TheCards(resetMap: true);
          for (var cardQnA in widget.theCards.cardQnA) {
            if (cardQnA["favorite"] as bool) {
              favoriteCards.cardQnA.add(cardQnA);
            }
          }

          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Favorite cards"),
                  IconButton(
                    icon: const Icon(Icons.help),
                    onPressed: _pushHelpPage,
                  ),
                ],
              ),
            ),
            body: MainColumn(
              theCards: favoriteCards,
              editOrOrderCard: editOrOrderCard,
              deleteCards: deleteCards,
              limitedVersion: true,
            ),
          );
        },
      ),
    );
  }

  void _pushHelpPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HelpPage(
        context: context,
      );
    }));
  }

  Future<void> _pushHelpPageHelper() async {
    await _loadBeginnerState();
    if (_beginnerState) {
      _pushHelpPage();
      await _saveBeginnerState();
    }
  }
}
