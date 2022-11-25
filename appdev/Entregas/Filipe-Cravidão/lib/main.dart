// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:is_first_run/is_first_run.dart';

bool state = false;

Future<void> showTutorial() async{
  state = IsFirstRun.isFirstRun() as bool;
}


void main() {
  showTutorial();

    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
      home: state ?   T1() : Home(),
      // se estas a ver este codigo, n consegui fazer o statefull funcionar...

    )
  );
}






class T1 extends StatelessWidget {
  const T1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/T1.PNG"),
            fit: BoxFit.cover,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const T2()),
          );
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}

class T2 extends StatelessWidget {
  const T2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset('assets/T2.PNG',
                  fit: BoxFit.cover
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const T3()),
          );
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}

class T3 extends StatelessWidget {
  const T3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset('assets/T3.PNG',
                  fit: BoxFit.cover
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Rand()),
                      );
                    },
                    child: Text(
                      "Randomizer",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
                  ),
              ],
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  height: 100,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Calculator()),
                        );
                      },
                      child: Text(
                        "Calculator",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



class Rand extends StatefulWidget {
  const Rand({Key? key}) : super(key: key);

  @override
  State<Rand> createState() => _RandState();
}

class _RandState extends State<Rand> {

  Future<List<int?>?> _getIntFromSharedPref() async{
    final prefs = await SharedPreferences.getInstance();
    info[0] = prefs.getInt('sup');
    info[1] = prefs.getInt('inf');
    info[2] = prefs.getInt('rand');
    info[3] = prefs.getInt('save1');
    info[4] = prefs.getInt('save2');
    info[5] = prefs.getInt('save3');
    info[6] = prefs.getInt('save4');
    info[7] = prefs.getInt('save5');
    if(info[0]==null){
      return null;
    }else{
      return info;
    }
  }

  Future<void> _upgradeIntFromSharedPref(info) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('sup',info[0]);
    prefs.setInt('inf',info[1]);
    prefs.setInt('rand',info[2]);
    prefs.setInt('save1',info[3]);
    prefs.setInt('save2',info[4]);
    prefs.setInt('save3',info[5]);
    prefs.setInt('save4',info[6]);
    prefs.setInt('save5',info[7]);
  }


  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  List<int?> info= [0,0,0,0,0,0,0,0]; // sup inf rand history (2,7)

  randomize(){
    setState(() {
      info[0] = int.parse(controller2.text);
      info[1] = int.parse(controller1.text);
      Random random = Random();
      info[2] = random.nextInt(1 + info[0]! - info[1]!) + info[1]!;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _getIntFromSharedPref());
    });

  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {

          _upgradeIntFromSharedPref(info);
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text("Randomizer"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 100, 0, 0)
                  ),
                  Text(
                    info[2].toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: (){
                        randomize();

                      }, child: Text("Randomize"))
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0)
                  ),
                  TextField(
                    controller: controller1,
                    decoration: InputDecoration(
                        labelText: "Inferior Limit",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0)
                  ),
                  TextField(
                    controller: controller2,
                    decoration: InputDecoration(
                        labelText: "Superior Limit",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: (){
                        setState(() {
                          info[7] = info[6];
                          info[6] = info[5];
                          info[5] = info[4];
                          info[4] = info[3];
                          info[3] = info[2];
                        });

                      }, child: Text("Save"))
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0)
                  ),
                  Text(
                    info[3].toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0)
                  ),
                  Text(
                    info[4].toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0)
                  ),
                  Text(
                    info[5].toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0)
                  ),
                  Text(
                    info[6].toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0)
                  ),
                  Text(
                    info[7].toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                ],
              ),
            )
        ),
    );


  }
}



class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);
  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }

      else if(buttonText == "⌫"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }

      else if(buttonText == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }

      }

      else{
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ),
          )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        children: <Widget>[


          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize),),
          ),


          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize),),
          ),


          Expanded(
            child: Divider(),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("⌫", 1, Colors.blue),
                          buildButton("C", 1, Colors.blue),
                          buildButton("÷", 1, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.black54),
                          buildButton("8", 1, Colors.black54),
                          buildButton("9", 1, Colors.black54),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.black54),
                          buildButton("5", 1, Colors.black54),
                          buildButton("6", 1, Colors.black54),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("1", 1, Colors.black54),
                          buildButton("2", 1, Colors.black54),
                          buildButton("3", 1, Colors.black54),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton(".", 1, Colors.black54),
                          buildButton("0", 1, Colors.black54),
                          buildButton("00", 1, Colors.black54),
                        ]
                    ),
                  ],
                ),
              ),


              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("×", 1, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.blue),
                        ]
                    ),
                  ],
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}
















