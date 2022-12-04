import 'package:flutter/material.dart';
import 'package:ppt/ppt.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[800],
        title: Text("Menu",),
      ),
      body: Center(
        child: Column(

          children: [
            Container(
              decoration: BoxDecoration(

              ),
              margin: EdgeInsets.all(50),
              padding: EdgeInsets.all(20),
              child: Card(
                child: Padding
                  (padding: EdgeInsets.all(10),
                    child: Text("Pedra, Papel & Tesoura\n\nPretty self-explanatory",style: TextStyle(fontSize: 20, color: Colors.white),)),
                color: Colors.deepPurple[800],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple[800],),

              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Ppt();
                      },
                    ),
                  );
                },
              child: Text("Jogar"),
            )
          ],
        ),
      ),
    );
  }
}

