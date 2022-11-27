import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/util.dart';
import 'core.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget{
	const MyApp({super.key});

	@override
	Widget build(BuildContext context){
		SystemChrome.setSystemUIOverlayStyle(
			const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'ToDo List',
      		home: AnimatedSplashScreen(
            	duration: 1500,
            	splash: Icons.check_box,
            	nextScreen: Core(),
            	splashTransition: SplashTransition.fadeTransition,
            	backgroundColor: blue),
		);
	}

}
