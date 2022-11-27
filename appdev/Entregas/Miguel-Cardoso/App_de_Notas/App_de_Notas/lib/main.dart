import 'package:flutter/material.dart';
import 'tutorial.dart';
import 'profile.dart';
import 'splash.dart';
//https://docs.flutter.dev/cookbook/persistence/key-value
void main(){
  runApp(FirstPage());
}

class FirstPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Splash(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List <Widget> pages = [
    Home(),
    Profile()
  ];
  int currentPage = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      

        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.blueGrey[800],
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Como usar?'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Notas'),
          ],
          onDestinationSelected: (int index) {
            setState(() {
              currentPage = index;
            });
          },
          selectedIndex: currentPage,

        ),
      

    );
  }
}