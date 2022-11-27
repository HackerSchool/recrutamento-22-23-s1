import 'package:example/tutorial.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Pagina();
  }
}

class Pagina extends StatefulWidget {
  const Pagina({super.key});

  @override
  State<Pagina> createState() => _PaginaState();
}

class _PaginaState extends State<Pagina> {

  int temp = 0;
  String input = '';
  var growableList= <String>[''];

  @override
  void initState(){
    super.initState();
    _loadLista();
  }

  Future<void> _loadLista() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      growableList = (prefs.getStringList('lista') ?? []);
    });
  }

  Future<void> _editarLista() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList('lista', growableList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      floatingActionButton: FloatingActionButton(
        onPressed: (){
         setState(() {
            growableList.add('');          
         });
         _editarLista();
        },
        backgroundColor: Colors.brown[400],
        child: Icon(Icons.add)
      ),

      appBar: AppBar(
        title: Text('Notas'),
        backgroundColor: Colors.blueGrey[700],
      ),
      backgroundColor: Colors.brown[700],


      body: Padding(
        padding: EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: growableList.length,
          itemBuilder: (BuildContext context, index){

            return Card(
              color: Colors.brown[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
              ),
              child: ListTile(
                title: Text('Nota ${index+1}: ${growableList[index]}'),

                trailing: Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.brown[400],
                              title: Text('Editar nota:'),
                  
                              content: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Por exemplo...',
                                ),
                                onChanged: (String value) {
                                  input = value;
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed:(){
                                    setState(() {                                      
                                      growableList[index]=input;                                     
                                    });
                                    Navigator.of(context).pop();
                                    _editarLista();
                                  },
                                  child: Text('Ok', style: TextStyle(color: Colors.black),),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: (){
                        setState(() {
                          growableList.removeAt(index);
                        });
                        _editarLista();
                      }, 
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          },

        ),
      ),
    );
  }
}