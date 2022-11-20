import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Game.dart';

class GameMenu extends StatefulWidget {
  const GameMenu({super.key});

  @override
  GameMenuState createState() => GameMenuState();
}

class GameMenuState extends State<GameMenu> {
  Future<List<int>> getStats() async {
    final prefs = await SharedPreferences.getInstance();

    int highScore = prefs.getInt("score") ?? 0;
    int apples = prefs.getInt("apples") ?? 0;

    return [highScore, apples];
  }

  void _pushGame() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const Game();
    }));
  }

  void _showStats() {
    getStats().then(
      (values) {
        showDialog(
            context: context,
            builder: ((BuildContext context) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.leaderboard_rounded,
                      color: Colors.lightBlue,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: Text(
                        "Stats",
                        style: TextStyle(fontSize: 25),
                      ),
                    )
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(' Highest Score: ${values[0]}',
                            style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.apple,
                          color: Color.fromARGB(255, 213, 1, 44),
                        ),
                        Text(' Apples eaten: ${values[1]}',
                            style: const TextStyle(fontSize: 18))
                      ],
                    )
                  ],
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Close',
                      style: TextStyle(
                          color: Color.fromARGB(255, 90, 227, 110),
                          fontSize: 18),
                    ),
                  )
                ],
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              );
            }));
      },
    );
  }

  void _showHelp() {
    showDialog(
        context: context,
        builder: ((BuildContext context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/snake.png",
                  width: 30,
                ),
                const Text(
                  "Help",
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
            content: const Text(
                'Use gestures (swipes) to control the snake movement. Your goal is to eat as many apples as possible without crashing the snake into itself.\n\nYou can always check your highest score on the "stats" panel.\n\nGood luck!',
                textAlign: TextAlign.center),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Close',
                  style: TextStyle(
                      color: Color.fromARGB(255, 90, 227, 110), fontSize: 18),
                ),
              )
            ],
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: const Color.fromARGB(255, 90, 227, 110),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/snake.png',
                    width: 300,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                      onPressed: _pushGame,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fixedSize: const Size(150, 50),
                      ),
                      child: const Text(
                        'Start',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                      onPressed: _showStats,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fixedSize: const Size(150, 50),
                      ),
                      child: const Text(
                        'Stats',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                      onPressed: _showHelp,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fixedSize: const Size(150, 50),
                      ),
                      child: const Text(
                        'Help',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
