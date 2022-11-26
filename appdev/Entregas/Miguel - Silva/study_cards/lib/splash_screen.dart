import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key, required this.backgroundColor}) : super(key: key);
  final Color? backgroundColor;

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              "assets/app_icon.png",
              height: 100,
              width: 200,
              fit: BoxFit.contain,
            ),
            const Divider(
              indent: 100,
              endIndent: 100,
              thickness: 2,
            ),
            const Text("Study Cards", style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
