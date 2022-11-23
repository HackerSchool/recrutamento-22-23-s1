import 'package:flutter/material.dart';
import 'baseClient.dart';
import 'screeen2.dart';
import 'splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Secret Santa',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Splash(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  // use this controller to keep track of what the user has typed
  TextEditingController _name = new TextEditingController();

  //save user input
  String userName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Secret Santa',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        elevation: 10,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("What's your name?"),
                    content: TextField(
                      controller: _name,
                      decoration: InputDecoration(
                        hintText: 'Maria Albertina',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _name.clear();
                          },
                          icon: const Icon(Icons.clear_rounded),
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            userName = _name.text;
                          });
                          Navigator.pop(context);
                          debugPrint(userName);
                        },
                        child: const Text('Save'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.person)),
        ],
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'images/wallpaper.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      var response = await BaseClient().delete('/delete-all');
                      debugPrint('Successfull Total deletion!!');

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => screen2(name: _name.text),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(150.0, 50.0)),
                    child: const Text(
                      'Get Started',
                      textScaleFactor: 1.5,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('How it works'),
                          content: const Text(
                            """
1- Press the start button.

2- Click on the button on the bottom right corner of the screen to add a new participant, and fill out the name and e-mail fields.

4- If you wish to delete any person added, click on the cross icon next to their name or click on the trash can icon on the top right corner of the screen to clear the whole list.

4- When all participants have been added, click on the mail icon on the top right corner of the screen.

5- It's all done! Each of you will receive an e-mail informing who is your secret santa.""",
                            textAlign: TextAlign.justify,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Icon(Icons.question_mark),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
