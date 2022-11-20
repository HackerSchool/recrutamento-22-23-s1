import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  static const int rowSize = 11;
  static const int colSize = 20;
  static const int numberOfSquares = rowSize * colSize;

  // the snake body
  List<int> snake = [27, 38, 49, 60, 71];
  // first food to spawn (on the lower part of the grid)
  int food = Random().nextInt(numberOfSquares ~/ 2) + numberOfSquares ~/ 2;
  // score
  int score = 0;

  // direction of the snake movement
  String direction = 'down';

  bool paused = true;
  bool gameStarted = false;

  void _updateStats() async {
    final prefs = await SharedPreferences.getInstance();

    int highScore = prefs.getInt("score") ?? 0;

    if (score > highScore) {
      await prefs.setInt("score", score);
    }

    int apples = prefs.getInt("apples") ?? 0;
    await prefs.setInt("apples", apples + score);
  }

  void _popGame() {
    Navigator.of(context).pop();
  }

  void startGame() {
    gameStarted = true;
    const duration = Duration(milliseconds: 150);

    Timer.periodic(duration, (Timer timer) {
      if (!this.mounted) {
        // if game was popped
        timer.cancel();
        _updateStats();
        return;
      }
      updateSnake();
      if (gameIsOver()) {
        // if player lost
        timer.cancel();
        gameOver();
      }
    });
  }

  void resumeGame() {
    paused = false;
    if (!gameStarted) {
      startGame();
    }
  }

  bool gameIsOver() {
    // checks if the snake crashed into itself
    if (snake.sublist(0, snake.length - 2).contains(snake.last)) return true;
    return false;
  }

  void gameOver() {
    _updateStats();
    setState(() {
      // remove the head so it doesn't appear inside the body
      snake.removeLast();
    });
    showDialog(
        context: context,
        // tapping the screen outside the dialog box doesn't close it
        barrierDismissible: false,
        builder: ((BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(90),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Game Over!'),
              ],
            ),
            content: Text(
              'Score: $score',
              textAlign: TextAlign.center,
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  resetGame();
                },
                child: const Text(
                  'Close',
                  style: TextStyle(color: Color.fromARGB(255, 90, 227, 110)),
                ),
              )
            ],
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          );
        }));
  }

  void resetGame() {
    snake = [27, 38, 49, 60, 71];
    food = Random().nextInt(numberOfSquares ~/ 2) + numberOfSquares ~/ 2;
    score = 0;

    direction = 'down';
    paused = true;
    gameStarted = false;

    setState(() {});
  }

  void updateSnake() {
    setState(() {
      if (paused) return;

      switch (direction) {
        case 'up':
          // top of the screen
          if (snake.last < rowSize) {
            snake.add(snake.last + numberOfSquares - rowSize);
          } else {
            snake.add(snake.last - rowSize);
          }
          break;
        case 'down':
          // bottom of the screen
          if (snake.last >= numberOfSquares - rowSize) {
            snake.add(snake.last - numberOfSquares + rowSize);
          } else {
            snake.add(snake.last + rowSize);
          }
          break;
        case 'right':
          // right side
          if ((snake.last + 1) % rowSize == 0) {
            snake.add(snake.last - rowSize + 1);
          } else {
            snake.add(snake.last + 1);
          }
          break;
        case 'left':
          // left side
          if (snake.last % rowSize == 0) {
            snake.add(snake.last + rowSize - 1);
          } else {
            snake.add(snake.last - 1);
          }
          break;
        default:
      }

      // if the snake ate the food
      if (snake.last == food) {
        score++;
        spawnFood();
      } else {
        snake.removeAt(0);
      }
    });
  }

  void spawnFood() {
    do {
      food = Random().nextInt(numberOfSquares);
    } while (snake.contains(food));
  }

  EdgeInsets getMargin(int pos) {
    int i = snake.indexOf(pos);
    double top = 1;
    double bot = 1;
    double left = 1;
    double right = 1;

    int prev = (i == 0 ? pos : snake.elementAt(i - 1));
    int next = (i == snake.length - 1 ? pos : snake.elementAt(i + 1));

    if (prev == pos - 1 || next == pos - 1) {
      // left
      left = 0;
    }
    if (prev == pos + 1 || next == pos + 1) {
      // right
      right = 0;
    }
    if (prev == pos + rowSize || next == pos + rowSize) {
      // down
      bot = 0;
    }
    if (prev == pos - rowSize || next == pos - rowSize) {
      // up
      top = 0;
    }
    return EdgeInsets.only(bottom: bot, top: top, left: left, right: right);
  }

  BorderRadius getBorderRadius(int pos) {
    int i = snake.indexOf(pos);
    double topRight = 0;
    double topLeft = 0;
    double botRight = 0;
    double botLeft = 0;

    if (pos == snake.elementAt(0) || pos == snake.elementAt(snake.length - 1)) {
      // if head or tail
      int prev = (i == 0 ? pos : snake.elementAt(i - 1));
      int next = (i == snake.length - 1 ? pos : snake.elementAt(i + 1));

      if (prev == pos - 1 || next == pos - 1) {
        // left
        botRight = topRight = 4;
      }
      if (prev == pos + 1 || next == pos + 1) {
        // right
        botLeft = topLeft = 4;
      }
      if (prev == pos + rowSize || next == pos + rowSize) {
        // down
        topLeft = topRight = 4;
      }
      if (prev == pos - rowSize || next == pos - rowSize) {
        // up
        botLeft = botRight = 4;
      }
    }

    return BorderRadius.only(
        topRight: Radius.circular(topRight),
        topLeft: Radius.circular(topLeft),
        bottomRight: Radius.circular(botRight),
        bottomLeft: Radius.circular(botLeft));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 90, 227, 110),
      body: Column(
        children: <Widget>[
          const Padding(padding: EdgeInsets.all(20)),
          Expanded(
              child: GestureDetector(
            onVerticalDragUpdate: (details) {
              if (paused) return;
              if (direction != 'up' && details.delta.dy > 0) {
                direction = 'down';
              } else if (direction != 'down' && details.delta.dy < 0) {
                direction = 'up';
              }
            },
            onHorizontalDragUpdate: (details) {
              if (paused) return;
              if (direction != 'right' && details.delta.dx < 0) {
                direction = 'left';
              } else if (direction != 'left' && details.delta.dx > 0) {
                direction = 'right';
              }
            },
            child: AspectRatio(
              aspectRatio: rowSize / (colSize + 4),
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowSize),
                  itemCount: numberOfSquares,
                  itemBuilder: ((context, index) {
                    var color = const Color.fromARGB(90, 173, 235, 200);
                    bool isSnake = false;
                    if (snake.last == index) {
                      /* check's head */
                      isSnake = true;
                      color = const Color.fromARGB(255, 173, 161, 243);
                    } else if (snake.contains(index)) {
                      /* check's body */
                      isSnake = true;
                      color = Colors.lightBlue;
                    } else if (food == index) {
                      /* check's food */
                      color = const Color.fromARGB(255, 213, 1, 44);
                    }

                    return Container(
                      margin: (isSnake
                          ? getMargin(index)
                          : const EdgeInsets.all(2)),
                      child: ClipRRect(
                        borderRadius: isSnake
                            ? getBorderRadius(index)
                            : BorderRadius.circular(4),
                        child: Container(color: color),
                      ),
                    );
                  })),
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                    onPressed: _popGame,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                TextButton(
                    onPressed: (() {
                      if (paused) {
                        resumeGame();
                      } else {
                        paused = true;
                      }
                    }),
                    style: TextButton.styleFrom(
                        backgroundColor: paused
                            ? Colors.lightBlue
                            : const Color.fromARGB(255, 213, 1, 44),
                        minimumSize: const Size(90, 40)),
                    child: Text(
                      paused ? 'Start' : 'Pause',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    )),
                Text('Score: $score',
                    style: const TextStyle(color: Colors.white, fontSize: 18))
              ],
            ),
          )
        ],
      ),
    );
  }
}
