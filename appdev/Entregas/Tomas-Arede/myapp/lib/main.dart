//packages
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


//my files

import './BottomBar.dart';
import './FloatingButtonPlus.dart';
import './AddDevicePage.dart';
import './OnBoarding.dart';

void main(){
  runApp(Animated());
}

class Animated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: AnimatedSplashScreen(
      duration: 2000,
      splash: Image.asset("assets/Logo.png"),
      nextScreen: OnboardingPage(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Color.fromARGB(255, 3, 58, 75),
      splashIconSize: 200,
    ));
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  //Main menu
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color.fromARGB(255, 3, 58, 75),
      home: Scaffold(
        floatingActionButton: FloatingButtonPlus(
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (cpntext) => AddDevicePage()));
            setState(() {});
          },
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked, //center it
        bottomNavigationBar: BottomBar(),
        appBar: AppBar(
          title: Column(children: [
            Text('Total: ' + AddDevicePageState.price_total.toStringAsFixed(2) + " €",
            textAlign: TextAlign.center)],),
          actions: [
            IconButton(onPressed: () async {
              Navigator.push(context,
              MaterialPageRoute(builder: (cpntext) => OnboardingPage()));
              setState(() {});
            }, 
            icon: const Icon(Icons.info))
          ],
          backgroundColor: Color.fromARGB(255, 3, 58, 75),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              DataPopUp(AddDevicePageState.dataList[index]),
          itemCount: AddDevicePageState.dataList.length,
        ),
      ),
    );
  }
}

class DataPopUp extends StatelessWidget {
  const DataPopUp(this.popup);

  final DataList popup;

  Widget _buildTiles(DataList root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<DataList>(root),
      title: Text(
        root.title,
      ),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(popup);
  }
}

