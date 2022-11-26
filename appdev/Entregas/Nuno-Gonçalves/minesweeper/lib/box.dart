import 'package:flutter/material.dart';

const myBackgroundColor = Color(0xff181b22);
const myPrimaryColor = Color(0xff95a9e4);
const mySecondaryColor = Color(0xff404558);
const myBombColor = Color(0xffcc0000);

class Box extends StatelessWidget {
  int number;
  bool revealed;
  bool isBomb;
  final onTapFunction;
  bool win;

  Box({
    super.key,
    required this.number,
    required this.revealed,
    required this.isBomb,
    required this.onTapFunction,
    required this.win,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: revealed
                ? (isBomb
                    ? (win ? mySecondaryColor : myBombColor)
                    : myBackgroundColor)
                : myPrimaryColor,
          ),
          child: revealed
              ? Center(
                  child: isBomb
                      ? Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset("assets/logo-bg.png"),
                        )
                      : Text(number == 0 ? "" : number.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)))
              : const Text(""),
        ),
      ),
    );
  }
}
