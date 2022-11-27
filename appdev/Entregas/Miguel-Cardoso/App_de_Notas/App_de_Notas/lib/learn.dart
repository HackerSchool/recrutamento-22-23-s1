import 'package:flutter/material.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Flutter'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [
            Image.asset('images/imagem.png'),
            SizedBox(height: 10,),
            Divider(color: Colors.black,),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              color: Colors.blueGrey,
              child: Center(
                child: Text('Contentor', 
                style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            OutlinedButton(
              onPressed: (){},
              child: Text('Botao'),
              ),
          ],
        ),
      ),
    );
  }
}