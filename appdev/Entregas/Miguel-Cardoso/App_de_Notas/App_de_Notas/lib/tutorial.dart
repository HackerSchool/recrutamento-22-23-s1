import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Tutorial();
  }
}

class Tutorial extends StatefulWidget {
  const Tutorial({super.key});

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[700],
      appBar: AppBar(
        title: Text('Como usar?'),
        backgroundColor: Colors.blueGrey[700],
      ),
      
      body: Container(
        decoration: BoxDecoration(
          color: Colors.brown[400],
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(40),
        padding: EdgeInsets.all(20),
        width: 700,
        child: Text(
          'Bem vindo à minha aplicação de Notas. Esta página serve como um tutorial da aplicação. \n\n'+
          'Na parte inferior do ecrã podes encontrar uma barra de navegação. Usa-a para navegares entre esta página e a página das Notas.\n\n'+
          'Na página das Notas podes criar, editar e eliminar as tuas notas. Fica à vontade para escreveres o que quiseres, filmes para ver, '
          'passwords... tudo o que quiseres. O objetivo é nunca mais te esqueceres de alguma coisa.',
          
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}