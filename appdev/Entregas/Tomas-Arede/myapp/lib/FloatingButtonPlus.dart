import 'package:flutter/material.dart';
import './AddDevicePage.dart';

class FloatingButtonPlus extends StatelessWidget {
  const FloatingButtonPlus({
    Key? key,
    required VoidCallback this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Color.fromARGB(255, 3, 58, 75),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
