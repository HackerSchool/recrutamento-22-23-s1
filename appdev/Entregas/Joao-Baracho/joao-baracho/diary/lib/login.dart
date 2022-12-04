// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './home.dart';
import './help.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _passwordTEC = TextEditingController();
  late bool first;

  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    first = p.getBool('first') ?? true;

    if (first == true) {
      p.setBool('first', false);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Help()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          heightFactor: double.infinity,
          widthFactor: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'My Diary',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 80,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: _passwordTEC,
                  textAlign: TextAlign.center,
                  showCursor: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'insert key',
                  ),
                ),
              ),
              IconButton(
                onPressed: (() {
                  if (_passwordTEC.text == '1234') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                  }
                  _passwordTEC.text = '';
                }),
                icon: Icon(
                  Icons.key,
                  size: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
