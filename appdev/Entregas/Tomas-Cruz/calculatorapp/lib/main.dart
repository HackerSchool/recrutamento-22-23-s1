import 'package:flutter/material.dart';
import 'calculator.dart';
import 'guide.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final screens = [Calculator(), Guide()];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            onTap: _onItemTapped,
            backgroundColor: Colors.grey.shade900,
            currentIndex: _currentIndex,
            selectedItemColor: Colors.amber[800],
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.calculate_rounded), label: "Calculator"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.question_mark_rounded),
                  label: "User's Guide"),
            ],
          ),
        ),
      ),
    );
  }
}
