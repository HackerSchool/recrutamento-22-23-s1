import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:project/GameMenu.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeSplashScreen(),
    );
  }
}

class HomeSplashScreen extends StatelessWidget {
  const HomeSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 1400,
      splash: Column(children: [
        Image.asset(
          "assets/images/snake.png",
          width: 300,
        ),
        const Text(
          "Snake Game",
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
        )
      ]),
      backgroundColor: const Color.fromARGB(255, 90, 227, 110),
      splashIconSize: 500,
      nextScreen: const GameMenu(),
    );
  }
}
