import 'package:flutter/material.dart';

import '../popup_messages/edit_card/edit_form.dart';

// This is the type used by the popup menu below.
enum Menu { itemOne, itemTwo }

class MyCard extends StatefulWidget {
  const MyCard({required this.card, required this.getElevation, required this.index, required this.editOrOrderCard, required this.deleteCards, required this.limitedVersion, super.key});
  final Map<String, Object> card;
  final Function getElevation;
  final int index;
  final Function({int? index, String? question, String? answer, bool? favorite}) editOrOrderCard;
  final Function(int index) deleteCards;
  final bool limitedVersion;
  //final Future<void> Function() editCardMenu;

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  bool viewAnswer = false;

  @override
  Widget build(BuildContext context) {
    //var f = TheCards();
    //print(theCards.cardQnA);
    //print(Theme.of(context));
    return Card(
      elevation: widget.getElevation(widget.index),
      //((widget.key == widget.cardElevation["elevatedCard"]) && widget.cardElevation["elevation?"] as bool) ? 14 : 3,
      shadowColor: Theme.of(context).colorScheme.primary, // Color.fromARGB(255, 232, 7, 7)
      borderOnForeground: false,
      color: (viewAnswer) ? Colors.deepPurple[900] : Theme.of(context).colorScheme.background, //Card background color
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: InkWell(
        onLongPress: (widget.limitedVersion) ? (() => null) : null, //Special big brain technique
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onTap: () {
          //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tap'),));
          setState(() {
            viewAnswer = !viewAnswer;
          });
        },
        child: ListTile(
          title: Text(
            (viewAnswer) ? widget.card["answer"] as String : widget.card["question"] as String,
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              (viewAnswer && !widget.limitedVersion)
                  ? PopupMenuButton(
                      child: const Icon(
                        Icons.menu_rounded,
                        color: Colors.grey,
                      ),
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                            PopupMenuItem<Menu>(
                              onTap: () {
                                Future.delayed(const Duration(seconds: 0), () => _editCardMenu(context));
                              }, //(() async => widget.editCardMenu())
                              child: const Text('Edit'),
                            ),
                            PopupMenuItem<Menu>(
                              onTap: (() => widget.deleteCards(widget.index)),
                              child: const Text('Delete'),
                            ),
                          ])
                  : IconButton(
                      icon: (widget.card["favorite"] as bool) ? const Icon(Icons.star) : const Icon(Icons.star_border_outlined),
                      onPressed: (() {
                        if (!widget.limitedVersion) {
                          widget.editOrOrderCard(index: widget.index, favorite: !(widget.card["favorite"] as bool));
                        }
                      }),
                    ),
              //const Icon(Icons.)
            ],
          ),
        ),
      ),
    );
  }

  void editCardMenuVariables({required String formQuestion, required String formAnswer}) {
    //Sempre q o user escrever algo isto executa. o child envia para o parent a cada alteração = pouco efeciente
    // o ideal era ser o parent a ir buscar ao child só quando se clicasse no butão add
    this.formQuestion = formQuestion;
    this.formAnswer = formAnswer;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String formQuestion = "";
  String formAnswer = "";

  Future<void> _editCardMenu(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit study card:'),
          content: EditForm(formKey: _formKey, changeCreateCardMenuVariables: editCardMenuVariables),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Edit'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Process data.
                  widget.editOrOrderCard(index: widget.index, question: formQuestion, answer: formAnswer, favorite: false);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
