import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget button(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          calculate(btntxt);
        },
        child: Text(
          btntxt,
          style: TextStyle(fontSize: 30, color: txtcolor),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: btncolor,
          fixedSize: Size(75, 75),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 20, 20),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        text,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 100,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //call buttons functions
                button('AC', Colors.grey, Colors.black),
                button('+/-', Colors.grey, Colors.black),
                button('%', Colors.grey, Colors.black),
                button('/', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //call buttons functions
                button('7', Colors.grey.shade800, Colors.white),
                button('8', Colors.grey.shade800, Colors.white),
                button('9', Colors.grey.shade800, Colors.white),
                button('*', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //call buttons functions
                button('4', Colors.grey.shade800, Colors.white),
                button('5', Colors.grey.shade800, Colors.white),
                button('6', Colors.grey.shade800, Colors.white),
                button('-', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //call buttons functions
                button('1', Colors.grey.shade800, Colors.white),
                button('2', Colors.grey.shade800, Colors.white),
                button('3', Colors.grey.shade800, Colors.white),
                button('+', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    calculate('0');
                  },
                  child: Text(
                    '0',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.grey.shade800,
                      fixedSize: Size(160, 75),
                      padding: EdgeInsets.fromLTRB(20, 20, 100, 20)),
                ),
                button('.', Colors.grey.shade800, Colors.white),
                button('=', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }

  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  String result = '';
  String finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  void calculate(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (btnText == '%') {
      result = (double.parse(result) / 100).toString();
      numOne = double.parse(result);
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      finalResult.toString().startsWith('-')
          ? finalResult = finalResult.toString().substring(1)
          : finalResult = '-' + finalResult.toString();
      result = finalResult;
      numOne = double.parse(finalResult);
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == '*') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == '*' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(finalResult);
      } else {
        numTwo = double.parse(finalResult);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == '*') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (int.parse(splitDecimal[1]) <= 0) {
        return result = splitDecimal[0];
      } else if (splitDecimal[1].length > 10) {
        return result =
            splitDecimal[0] + '.' + splitDecimal[1].replaceRange(9, null, '');
      }
    }
    return result;
  }
}
