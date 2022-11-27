import 'dart:math';

import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> numberPad = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    '=',
    '1',
    '2',
    '3',
    '0',
  ];

  String userAnswer = '';
  var randomNumber = Random();
  int numA = 1;
  int numB = 1;

  void checkResultVariables() {
    if (numA * numB == int.parse(userAnswer)) {
      showResult('Correct!', next, Icons.arrow_forward);
    } else {
      showResult('Try again:)', repeat, Icons.rotate_90_degrees_ccw);
    }
  }

  void showResult(message, onTap, icon) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.orange,
            content: SizedBox(
              height: 150,
              child: Column(
                children: [
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: onTap,
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Colors.orange[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            icon,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        checkResultVariables();
      } else if (button == 'C') {
        userAnswer = '';
      } else {
        userAnswer += button;
      }
    });
  }

  void next() {
    Navigator.of(context).pop();
    setState(() {
      userAnswer = '';
    });
    numA = randomNumber.nextInt(10);
    numB = randomNumber.nextInt(10);
  }

  void repeat() {
    Navigator.of(context).pop();
    setState(() {
      userAnswer = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello'),
      ),
      backgroundColor: Colors.deepOrange,
      body: Column(
        children: [
          //question

          Expanded(
            child: Container(
              color: Colors.orange[300],
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$numA * $numB = ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          userAnswer,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //number pad
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.orange[300],
              child: GridView.builder(
                itemCount: 12,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: () => buttonTapped(numberPad[index]),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            numberPad[index],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
