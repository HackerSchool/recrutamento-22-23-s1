// ignore_for_file: prefer_const_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:diary/home.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import './login.dart';
import './home.dart';
import './help.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: Home(),
      home: AnimatedSplashScreen(
        duration: 2000,
        splash: Icons.all_inclusive_outlined,
        nextScreen: Login(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Colors.grey,
      ),
    );
  }
}
