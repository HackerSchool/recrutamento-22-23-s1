import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key, required this.context});
  final BuildContext context;

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final TextStyle MyDefaultTextStyle = const TextStyle(fontSize: 14, color: Color.fromARGB(255, 46, 49, 56));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Help Page")),
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: ListView(
            children: [
              RichText(
                text: TextSpan(text: "", style: MyDefaultTextStyle, children: <TextSpan>[
                  const TextSpan(text: "Hi!\n", style: TextStyle(fontSize: 31, color: Color.fromARGB(255, 46, 49, 56))),
                  TextSpan(text: "Thank you for downloading the ", style: MyDefaultTextStyle),
                  const TextSpan(text: "Study Cards app!", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 15, color: Color.fromARGB(255, 46, 49, 56))),
                ]),
              ),
              Divider(),
              RichText(
                text: TextSpan(text: "", style: MyDefaultTextStyle, children: <TextSpan>[
                  const TextSpan(
                      style: TextStyle(fontWeight: FontWeight.normal, fontStyle: FontStyle.italic, fontSize: 14, color: Color.fromARGB(210, 46, 49, 56)),
                      text: "School can be hard sometimes, there are a lot of things to learn and, unfortunately, some of them come down to just memorizing arbitrary things. \n\n"),
                  TextSpan(style: MyDefaultTextStyle, text: "To "),
                  const TextSpan(style: TextStyle(fontWeight: FontWeight.normal, fontStyle: FontStyle.italic, fontSize: 14, color: Color.fromARGB(255, 46, 49, 56)), text: "\thelp you"),
                  TextSpan(style: MyDefaultTextStyle, text: " with that use "),
                  const TextSpan(style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 14, color: Color.fromARGB(255, 46, 49, 56)), text: "Study Cards!\n"),
                  TextSpan(style: MyDefaultTextStyle, text: "\nYou can "),
                  const TextSpan(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color.fromARGB(255, 46, 49, 56)), text: "add a question and answer"),
                  TextSpan(style: MyDefaultTextStyle, text: " card by clicking the bottom right button. Now, you can "),
                  const TextSpan(
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color.fromARGB(255, 46, 49, 56)), text: "tap it to view the answer and question and long press it to reorder"),
                  TextSpan(style: MyDefaultTextStyle, text: " as you fancy!"),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/add_question.png',
                      //width: 200,
                      height: 150,
                      //scale: 1,
                      fit: BoxFit.contain,
                      semanticLabel: "add_question",
                    ),
                    Image.asset(
                      'assets/longpress.png',
                      //width: 200,
                      height: 150,
                      //scale: 1,
                      fit: BoxFit.contain,
                      semanticLabel: "long press",
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(text: "", style: MyDefaultTextStyle, children: <TextSpan>[
                  TextSpan(style: MyDefaultTextStyle, text: "You can "),
                  const TextSpan(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color.fromARGB(255, 46, 49, 56)), text: "add it to your \"favorites\""),
                  TextSpan(style: MyDefaultTextStyle, text: " list by clicking the start icon and you also have the ability to "),
                  const TextSpan(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color.fromARGB(255, 46, 49, 56)), text: "change and delete card"),
                  TextSpan(style: MyDefaultTextStyle, text: " as you wish! (the edit and delete button are on the answer side of the card). If you wish to "),
                  const TextSpan(style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, fontSize: 14, color: Color.fromARGB(255, 46, 49, 56)), text: "only see your favorite cards"),
                  TextSpan(style: MyDefaultTextStyle, text: " press the button on the top right corner of the app."),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/favorite_edit_delete.png',
                      //width: 200,
                      height: 150,
                      //scale: 1,
                      fit: BoxFit.contain,
                      semanticLabel: "add_question",
                    ),
                    Image.asset(
                      'assets/2favorite.png',
                      //width: 200,
                      height: 150,
                      //scale: 1,
                      fit: BoxFit.contain,
                      semanticLabel: "long press",
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(text: "", style: MyDefaultTextStyle, children: <TextSpan>[
                  TextSpan(style: MyDefaultTextStyle, text: "On the \"Favorite cards\" menu you will have all your favorite cards and also a button on the top right corner witch leads to this page."),
                  //const TextSpan(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color.fromARGB(255, 46, 49, 56)), text: "add it to your \"favorites\""),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/only_favorite_e_help.png',
                      //width: 200,
                      height: 150,
                      //scale: 1,
                      fit: BoxFit.contain,
                      semanticLabel: "add_question",
                    ),
                    /*Image.asset(
                      'assets/2favorite.png',
                      //width: 200,
                      height: 150,
                      //scale: 1,
                      fit: BoxFit.contain,
                      semanticLabel: "long press",
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
