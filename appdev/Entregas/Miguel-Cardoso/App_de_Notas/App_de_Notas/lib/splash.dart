import 'package:example/main.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    _navegar();
  }

  _navegar()async{
    await Future.delayed(Duration(milliseconds: 2000));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => RootPage())));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [Color(0xFF8D6E63), Color(0xFF3E2723)],
          ),
        ),
        child:Center(
          child: Container(
            width: 300,
            child: Image.asset(
                  'images/logo.png',
            ),
          ),
        ),
      ),
    );
  }
}