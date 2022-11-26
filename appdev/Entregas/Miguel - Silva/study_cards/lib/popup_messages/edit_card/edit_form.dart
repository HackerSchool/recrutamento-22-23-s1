import 'package:flutter/material.dart';


class EditForm extends StatefulWidget {
  const EditForm({required this.formKey, required this.changeCreateCardMenuVariables, super.key}); //required this.changeCreateCardMenuVariables,
  final GlobalKey<FormState> formKey;
  final Function({required String formQuestion, required String formAnswer}) changeCreateCardMenuVariables;

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final questionController = TextEditingController();
  final answerController = TextEditingController();
  String question = "";
  String answer = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    questionController.dispose();
    answerController.dispose();
    super.dispose();
  }

  //void addCard({required String question, required String answer, required bool favorite}) {}
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      onChanged: () {
        setState(() {
          String question = questionController.text;
          String answer = answerController.text;
          widget.changeCreateCardMenuVariables(formQuestion: question, formAnswer: answer);
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('Q: ', style: TextStyle(color: Color.fromARGB(210, 50, 34, 55), fontSize: 28, fontStyle: FontStyle.italic)),
              Expanded(
                child: TextFormField(
                  controller: questionController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Write your question',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const Divider(
            height: 30,
            thickness: 0.0,
            color: Color.fromARGB(0, 1, 1, 1),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('A: ', style: TextStyle(color: Color.fromARGB(210, 50, 34, 55), fontSize: 28, fontStyle: FontStyle.italic)),
              Expanded(
                child: TextFormField(
                  controller: answerController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Write your answer',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
