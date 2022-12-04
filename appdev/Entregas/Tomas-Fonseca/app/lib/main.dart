import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await openDatabase(
    Path.join(await getDatabasesPath(), 'notesdatabase.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE notes(title TEXT,text TEXT)',
      );
    },
    version: 1,
  );   
  final List<Map<String, dynamic>> maps = await database.query('notes');

  var listNotes = List.generate(maps.length, (i) { 
    return Note(title: maps[i]['title'], text: maps[i]['text']);
  });  

  List<Widget> notes = [];
  for (var ind=0;ind<listNotes.length;ind++) {
    if (listNotes[ind].title!=null && listNotes[ind].text!=null) {
      Widget widgetNote = Container(
        margin: const EdgeInsets.symmetric(horizontal: 6.5),
        padding: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
        ),
        child: Column(
          children: <Widget> [
            Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 8.0), 
              child: Text(
                listNotes[ind].title,
                style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 13, right: 13),
              child: Text(
                listNotes[ind].text, 
                style: TextStyle(fontSize: 14.5),
                textAlign: TextAlign.justify,
              ),
            ),
          ], 
        ),
      );
      notes.add(widgetNote);
    }
  }

  Saver newSave = Saver(notes);

  runApp(MyApp());
}

void deleteNote(title, text) async{
  WidgetsFlutterBinding.ensureInitialized();

  final database = await openDatabase(
      Path.join(await getDatabasesPath(), 'notesdatabase.db'),
      version: 1,
  );

  await database.delete(
    'notes',
    where: 'title = ?',
    whereArgs: [text],
  );

  Saver saver = Saver.n();
}

class MyApp extends StatelessWidget {
    static const String _title = 'Flutter Code Sample';

    Widget a = new HomePage();

    @override
    Widget build(BuildContext context) {
    	return MaterialApp(
            home: a,
            debugShowCheckedModeBanner: false,
	    );
    }
}

class HomePage extends StatefulWidget {
    HomePage({Key? key}) : super(key: key);

    @override
    SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<HomePage> {
    @override
    void initState() {
        super.initState();
        Timer(Duration(seconds: 5),
            () => Navigator.pushReplacement(context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen()
                    )
                )
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: ListView(
                children: [Padding(padding: EdgeInsets.only(top:120), child:Image(image: AssetImage('assets/images/logo.png'),
                        width: 300.00,
                        height: 300.00,
                    ),),
                ]
            )
        ); 
    }
}

class PreviousNotes extends StatelessWidget {
    int _selectedIndex = 2;

    static const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

    static const List<Widget> _widgetOptions = <Widget>[
	    Text(
	        'HOME PAGE',
	        style: optionStyle,
            textAlign: TextAlign.center,
	    ),
	    Text(
	        'NEW NOTE',
	        style: optionStyle,
            textAlign: TextAlign.center,
	    ),
	    Text(
	        'PREVIOUS NOTES',
	        style: optionStyle,
            textAlign: TextAlign.center,
	    ),
    ];

    @override
    Widget build(BuildContext context) {
      Saver saver = new Saver.n();
      List<Widget> notes = saver.getNotes();
    	return Scaffold(
            appBar: AppBar(
                title: Text('Notepad--'),
                backgroundColor: Colors.green,
            ),
    	    body: SafeArea(
            child: Container(child: Column(children: <Widget> [
              _widgetOptions.elementAt(_selectedIndex),
              Expanded(child: ListView(
                children: notes,
              ),),
            Image(image: AssetImage('assets/images/logo.png'),
                        width: 85.00,
                        height: 85.00,
                    ),
            ],
            ),),
          ),
    	    bottomNavigationBar: BottomNavigationBar(
    		    items: const <BottomNavigationBarItem>[
    		        BottomNavigationBarItem(
    			        icon: Icon(Icons.home),
    			        label: 'Home',
    		        ),
    		        BottomNavigationBarItem(
    			        icon: Icon(Icons.add_circle_rounded),
    			        label: 'New Note',
    		        ),
    		        BottomNavigationBarItem(
    			        icon: Icon(Icons.bookmark),
    			        label: 'Previous Notes', 
    		        ),
    		    ],
    		    currentIndex: _selectedIndex,
    		    selectedItemColor: Colors.amber[800],
    		    onTap: (index) {
                    switch (index) {
                        case 0:
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                            break;
                        case 1:
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NewNote()),
                            );
                            break;
                    }
                },
    	    ),
    	);
    }
}

class NewNote extends StatefulWidget {
    NewNote ({Key? key}) : super(key: key);

    @override
    NewNoteState createState() => NewNoteState();
}

class NewNoteState extends State<NewNote> {
    static final titleController = TextEditingController();

    static final controller = TextEditingController();

    int _selectedIndex = 1;

    static const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

    static const List<Widget> _widgetOptions = <Widget>[
	    Text(
	        'HOME PAGE',
	        style: optionStyle,
            textAlign: TextAlign.center,
	    ),
	    Text(
	        'NEW NOTE',
	        style: optionStyle,
            textAlign: TextAlign.center,
	    ),
	    Text(
	        'PREVIOUS NOTES',
	        style: optionStyle,
            textAlign: TextAlign.center,
	    ),
    ];

    Widget newNote = Padding(
        padding: EdgeInsets.all(16.0),
        child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
                hintText: 'Type in your new note',
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            validator: (String? value) {
                if (value==null || value.isEmpty) {
                    return 'Please enter some text';
                }
                return null;
            },
        )
    );

    Widget title = Padding(
        padding: EdgeInsets.fromLTRB(100, 30, 100, 30),
        child: TextFormField(
            controller: titleController,
            decoration: InputDecoration(
                hintText: 'Give your note a title',
            ),
        )
    );

    void buttonPressed(BuildContext context) {
        if (controller.text!=null && controller.text.isEmpty==false &&
            titleController.text!=null && titleController.text.isEmpty==false) {
            createFile(titleController.text, controller.text);
            showDialog(
                context: context,
                builder: (context) {
                    return AlertDialog(
                        content: Text('Note saved successfully!'),
                    );
                }
            );
        }
        else if (titleController.text==null || titleController.text.isEmpty==true) {
            showDialog(
                context: context,
                builder: (context) {
                    return AlertDialog(
                        content: Text('Please give your note a title'),
                    );
                }
            );
        }
        else {
            showDialog(
                context: context,
                builder: (context) {
                    return AlertDialog(
                        content: Text('Please write something'),
                    );
                }
            );
        }
    } 

    void createFile(String _title, String _text) async {
        WidgetsFlutterBinding.ensureInitialized();
        final database = await openDatabase(
            Path.join(await getDatabasesPath(), 'notesdatabase.db'),
            version: 1,
        );
        var note = Note(title:_title, text: _text);

        await database.insert('notes', note.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

        Saver saver = Saver.n();
        saver.add(note);
    }

    @override
    void dispose() {
        controller.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
    	return Scaffold(
            appBar: AppBar(
                title: Text('Notepad--'),
                backgroundColor: Colors.green,
            ),
    	    body: ListView(
                children: [
                    _widgetOptions.elementAt(_selectedIndex),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                      ),
                      child: Column(
                        children: [title,newNote],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FloatingActionButton(
                            onPressed: () => {buttonPressed(context)}, 
                            child: Icon(Icons.save),
                            backgroundColor: Colors.green,
                        ),
                    ), 
                    Image(image: AssetImage('assets/images/logo.png'),
                        width: 85.00,
                        height: 85.00,
                    ),
                ]
            ),
    	    bottomNavigationBar: BottomNavigationBar(
    		    items: const <BottomNavigationBarItem>[
    		        BottomNavigationBarItem(
    			        icon: Icon(Icons.home),
    			        label: 'Home',
    		        ),
    		        BottomNavigationBarItem(
    			        icon: Icon(Icons.add_circle_rounded),
    			        label: 'New Note',
    		        ),
    		        BottomNavigationBarItem(
    			        icon: Icon(Icons.bookmark),
    			        label: 'Previous Notes', 
    		        ),
    		    ],
    		    currentIndex: _selectedIndex,
    		    selectedItemColor: Colors.amber[800],
    		    onTap: (index) {
                    switch (index) {
                        case 0:
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                            break;
                        case 2:
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PreviousNotes()),
                            );
                            break;
                    }
                },
    	    ),
    	);
    }
}

class Note {
    String title;
    String text;

    Note( {
        required this.title,
        required this.text
        } 
    );

    Map<String, dynamic> toMap() {
        return {
            'title': title,
            'text': text,
        };
    }
}

class Saver {
  static List<Widget> _notes = [];

  Saver.n() { }

  Saver(List<Widget> notes) {
    _notes = notes;
  }

  List<Widget> getNotes() { return _notes; }

  void add(Note note) { 
    Widget widgetNote = Container(
        margin: const EdgeInsets.symmetric(horizontal: 6.5),
        padding: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
        ),
      child: Padding(padding: EdgeInsets.only(top:16, bottom: 8), child: Column(
        children: <Widget> [
          Text(note.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          Text(note.text, 
            style: TextStyle(fontSize: 14.5),
          ),
        ], 
      ),),);
    _notes.add(widgetNote);
  }
}

class HomeScreen extends StatelessWidget {
    int _selectedIndex = 0;

    static const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

    static const List<Widget> _widgetOptions = <Widget>[
	    Text(
	        'HOME PAGE',
	        style: optionStyle,
            textAlign: TextAlign.center,
	    ),
	    Text(
	        'NEW NOTE',
	        style: optionStyle,
            textAlign: TextAlign.center,
	    ),
	    Text(
	        'PREVIOUS NOTES',
	        style: optionStyle,
            textAlign: TextAlign.center,
	    ),
    ];

    Widget titleSection = Container(
        padding: const EdgeInsets.all(32),
        child: Row(
            children: [
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: const Text(
                                    'How to Use',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                    ),
                                ),
                            ),
                            Text(
                                'This is a simple note writing app. Hence its baptism name Notepad--\n\nTo write a new note, go to the New Note'+
                                ' section, give it a title and some text and then save it with the button below.'+
                                '\n\nOnce that is done, you can review your past notes in the Previous Notes section.\n\nEnjoy Notepad--',
                                style: TextStyle(
                                    fontSize: 14.5,
                                ),
                            ),
                        ],
                    ),
                ),
            ],
        ),
    );

    @override
    Widget build(BuildContext context) {
    	return Scaffold(
            appBar: AppBar(
                title: Text('Notepad--'),
                backgroundColor: Colors.green,
            ),
    	    body: ListView(
                children: [
                    _widgetOptions.elementAt(_selectedIndex),
                    titleSection,
                    Image(image: AssetImage('assets/images/logo.png'),
                        width: 85.00,
                        height: 85.00,
                    )
                ]
            ),
    	    bottomNavigationBar: BottomNavigationBar(
    		    items: const <BottomNavigationBarItem>[
    		        BottomNavigationBarItem(
    			        icon: Icon(Icons.home),
    			        label: 'Home',
    		        ),
    		        BottomNavigationBarItem(
    			        icon: Icon(Icons.add_circle_rounded),
    			        label: 'New Note',
    		        ),
    		        BottomNavigationBarItem(
    			        icon: Icon(Icons.bookmark),
    			        label: 'Previous Notes', 
    		        ),
    		    ],
    		    currentIndex: _selectedIndex,
    		    selectedItemColor: Colors.amber[800],
    		    onTap: (index) {
                    switch (index) {
                        case 1:
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NewNote()),
                            );
                            break;
                        case 2:
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PreviousNotes()),
                            );
                            break;
                    }
                },
    	    ),
    	);
    }
}
