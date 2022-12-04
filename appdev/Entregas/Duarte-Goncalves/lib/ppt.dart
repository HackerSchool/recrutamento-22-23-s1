import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ppt extends StatefulWidget {
  const Ppt({Key? key}) : super(key: key);

  @override
  State<Ppt> createState() => _PptState();
}

class _PptState extends State<Ppt> {
  int escolha = 0;
  int num = 0;
  List lista = ["Pedra", "Papel", "Tesoura"];
  Random escolher = Random();
  _gerarNumero(){
    setState(() {
      num = escolher.nextInt(3);
    });
  }
  _avaliar(){
    if (escolha == num){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.yellow[300],
            content: Container(
              height: 130,
              child: Center(
                  child:
                    Text("Empate!, eu também escolhi ${lista[num]}")
                ),
              ),
            ),

      );
    }
    else if (escolha == 0 && num == 1 || escolha == 1 && num == 2 || escolha == 2 && num == 0){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.yellow[300],
            content: Container(
              height: 130,
              child: Center(
                  child:
                    Text("Perdeste!, eu escolhi ${lista[num]}",)
                ),
              ),
            ),

      );
    }
    else if (escolha == 0 && num == 2 || escolha == 1 && num == 0 || escolha == 2 && num == 1){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.yellow[300],
            content: Container(
              height: 130,
              child: Center(
                  child:
                    Text("Venceste!, eu escolhi ${lista[num]}")
                ),
              ),
            ),

      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[800],
        title: Text("Jogo"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              child: Text("Bem-vindo ao jogo, boa sorte!", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),)),
          Center(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
              style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple[800],),
                    onPressed: (){
                      setState(() {
                        _gerarNumero();
                        escolha = 0;
                        _avaliar();
                      });
                      },
                    child: Text("Pedra",
                              style: TextStyle(fontSize: 20),),),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[800],),
                    onPressed: (){
                      setState(() {
                        _gerarNumero();

                        escolha = 1;
                        _avaliar();
                      });
                      },
                    child: Text("Papel",
                              style: TextStyle(fontSize: 20),),),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[800],),
                    onPressed: (){
                      setState(() {
                        _gerarNumero();

                        escolha = 2;
                        _avaliar();
                      });
                    },
                    child: Text("Tesoura",
                              style: TextStyle(fontSize: 20),),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
