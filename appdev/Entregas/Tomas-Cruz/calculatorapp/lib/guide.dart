import 'package:flutter/material.dart';

class Guide extends StatelessWidget {
  Widget circle(String txt, Color circlecolor, Color txtcolor) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(width: 0),
        shape: BoxShape.circle,
        color: circlecolor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            txt,
            style: TextStyle(
                fontSize: 22, color: txtcolor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget formattedText(String txt) {
    return Text(
      txt,
      style: TextStyle(fontSize: 22, color: Colors.white70),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
          title: Text("User's Guide"),
          centerTitle: true,
          backgroundColor: Colors.grey.shade900),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Just as every other calculator, this one is pretty straight forward and simple to use. Below you'll find what each button is meant for:",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    circle('AC', Colors.grey, Colors.black),
                    SizedBox(width: 10),
                    formattedText("Resets calculator.")
                  ]),
                  Row(children: [
                    circle('+/-', Colors.grey, Colors.black),
                    SizedBox(width: 10),
                    formattedText(
                        "Changes a negative number to a positive one, and vice-versa.")
                  ]),
                  Row(children: [
                    circle('%', Colors.grey, Colors.black),
                    SizedBox(width: 10),
                    formattedText(
                        "Changes the number to percentage (number * 1/100).")
                  ]),
                  Row(children: [
                    circle('/', Colors.amber.shade700, Colors.white),
                    SizedBox(width: 10),
                    formattedText("Divides two given numbers.")
                  ]),
                  Row(children: [
                    circle('+', Colors.amber.shade700, Colors.white),
                    SizedBox(width: 10),
                    formattedText("Sums two given numbers.")
                  ]),
                  Row(children: [
                    circle('-', Colors.amber.shade700, Colors.white),
                    SizedBox(width: 10),
                    formattedText("Subtracts two given numbers.")
                  ]),
                  Row(children: [
                    circle('*', Colors.amber.shade700, Colors.white),
                    SizedBox(width: 10),
                    formattedText("Multiplies two given numbers.")
                  ]),
                  Row(children: [
                    circle('=', Colors.amber.shade700, Colors.white),
                    SizedBox(width: 10),
                    formattedText("Shows the result of the calculation.")
                  ]),
                  SizedBox(
                    height: 45,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
