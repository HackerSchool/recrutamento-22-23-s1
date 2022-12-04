import 'package:flutter/material.dart';
import './AddDevicePage.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        //bottom navigation bar on scaffold
        color: Color.fromARGB(255, 3, 58, 75),
        shape: CircularNotchedRectangle(), //shape of notch
        notchMargin:
            5, //notche margin between floating button and bottom appbar
        child: Container(
          height: 48.0,
        ));
  }
}
