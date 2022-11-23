import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'baseClient.dart';

class screen2 extends StatefulWidget {
  String name;

  screen2({required this.name});

  @override
  State<screen2> createState() => _screen2State();
}

class _screen2State extends State<screen2> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _mail = new TextEditingController();

  List friends = [];
  List<List> saved_friends = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Welcome ${widget.name}',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          elevation: 10,
          actions: [
            IconButton(
                onPressed: () async {
                  var response = await BaseClient().delete('/delete-all');

                  setState(() {
                    friends = [];
                  });
                },
                icon: Icon(Icons.delete)),
            IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Container(
                        height: 130,
                        child: Center(
                          child: Column(children: const [
                            Icon(Icons.send, size: 70, color: Colors.red,),
                            SizedBox(height: 10.0),
                            Text(
                              'An e-mail has been sent to each of you!',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(64, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ]),
                        ),
                      ),
                    ),
                  );
                  var response = await BaseClient().delete('/call-santa');
                },
                icon: Icon(Icons.mail_rounded)),
          ]),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(friends[index]['name']),
            subtitle: Text(friends[index]['mail']),
            trailing: IconButton(
              icon: Icon(Icons.clear_rounded),
              onPressed: () async {
                var response =
                    await BaseClient().delete('/delete-person/$index');

                setState(() {
                  friends.removeAt(index);
                });
                print(friends);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Center(child: Text('Add Friend')),
              actions: [
                TextButton(
                    onPressed: () async {
                      var person = {'name': _name.text, 'mail': _mail.text};
                      var response =
                          await BaseClient().post('/add-person', person);
                      //if (response == null) return;

                      setState(() {
                        friends.add({'name': _name.text, 'mail': _mail.text});
                      });
                      print(friends);
                      Navigator.pop(context);
                    },
                    child: Text('Save')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Delete')),
              ],
              content: Container(
                width: 400,
                height: 120,
                child: Column(
                  children: [
                    TextField(
                      controller: _name,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _name.clear();
                          },
                          icon: const Icon(Icons.clear_rounded),
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    TextField(
                      controller: _mail,
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _mail.clear();
                          },
                          icon: const Icon(Icons.clear_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        tooltip: 'Add new friend',
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
