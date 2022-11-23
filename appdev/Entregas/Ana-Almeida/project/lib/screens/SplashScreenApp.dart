import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project/screens/home.dart';
import 'package:project/utils/color.dart';

class SplashScreenApp extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreenApp> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 6),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColor.primary,
        // child: FlutterLogo(size: MediaQuery.of(context).size.height)
        child: Image.asset('icon/icon.png'));
  }
}
