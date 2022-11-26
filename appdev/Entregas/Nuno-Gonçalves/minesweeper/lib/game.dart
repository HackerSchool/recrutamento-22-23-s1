import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "dart:math";
import "dart:async";
import "box.dart";

const myBackgroundColor = Color(0xff181b22);
const myPrimaryColor = Color(0xff95a9e4);
const mySecondaryColor = Color(0xff404558);

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  final NUMBER_OF_BOXES = 9 * 9;
  final BOXES_IN_EACH_ROW = 9;
  final NUMBER_OF_BOMBS = 10;

  // [number of bombs around, revealed]
  var board = [];

  final List<int> bombsLocation = [];
  bool win = false;

  Duration time = const Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();

    // initialize bombsLocation
    for (int i = 0; i < NUMBER_OF_BOMBS; i++) {
      int randomIndex = (Random()).nextInt(NUMBER_OF_BOXES);
      while (bombsLocation.contains(randomIndex)) {
        randomIndex = (Random()).nextInt(NUMBER_OF_BOXES);
      }
      bombsLocation.add(randomIndex);
    }

    // initially, each square has 0 bombs around and is not revealed
    for (int i = 0; i < NUMBER_OF_BOXES; i++) {
      board.add([0, false]);
    }

    scanBombs();

    // number of bombs around needs to be != 0
    bombsLocation.forEach((index) {
      board[index][0] = 9;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(
        () {
          final seconds = time.inSeconds + 1;
          time = Duration(seconds: seconds);
        },
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(Image.asset("assets/logo-bg.png").image, context);
    precacheImage(Image.asset("assets/logo-white.png").image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (() {
                        timer?.cancel();
                        Navigator.pop(context);
                      }),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: mySecondaryColor,
                        child: const Icon(Icons.arrow_back,
                            color: Colors.white, size: 40),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 20,
                                child: Image.asset(
                                  "assets/logo-white.png",
                                  filterQuality: FilterQuality.medium,
                                )),
                            Text(" ${bombsLocation.length.toString()}",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white)),
                          ],
                        ),
                        Text(formatTime(),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white)),
                      ],
                    ),
                    GestureDetector(
                      onTap: restartGame,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: mySecondaryColor,
                        child: const Icon(Icons.refresh,
                            color: Colors.white, size: 40),
                      ),
                    ),

                    // display time taken
                  ],
                ),
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: NUMBER_OF_BOXES,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: BOXES_IN_EACH_ROW),
                  itemBuilder: (context, index) {
                    return Box(
                      number: board[index][0],
                      revealed: board[index][1],
                      isBomb: bombsLocation.contains(index),
                      win: win,
                      onTapFunction: () {
                        revealBox(index);

                        // check how many boxes yet to reveal
                        List<int> unrevealedBoxes = [];
                        for (int i = 0; i < NUMBER_OF_BOXES; i++) {
                          if (board[i][1] == false) {
                            unrevealedBoxes.add(i);
                          }
                        }

                        if (unrevealedBoxes.length == NUMBER_OF_BOMBS) {
                          bool victory = true;
                          unrevealedBoxes.forEach(((i) {
                            if (!bombsLocation.contains(i)) victory = false;
                          }));

                          if (victory) won();
                        }
                      },
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  void revealBombs() {
    bombsLocation.forEach((bombIndex) {
      board[bombIndex][1] = true;
    });
    setState(
      () {},
    );
  }

  void revealBox(int index) {
    // reveal current box if it is a number != 0
    if (board[index][0] != 0) {
      if (bombsLocation.contains(index)) {
        revealBombs();
        lost();
      } else {
        setState(() {
          board[index][1] = true;
        });
      }
    }
    // reveal current box and surrounding boxes
    else {
      setState(() {
        board[index][1] = true;

        // reveal top left box
        if (index % BOXES_IN_EACH_ROW != 0 && index >= BOXES_IN_EACH_ROW) {
          if (board[index - 1 - BOXES_IN_EACH_ROW][0] == 0 &&
              board[index - 1 - BOXES_IN_EACH_ROW][1] == false) {
            revealBox(index - 1 - BOXES_IN_EACH_ROW);
          }
          board[index - 1 - BOXES_IN_EACH_ROW][1] = true;
        }

        // reveal top box
        if (index >= BOXES_IN_EACH_ROW) {
          if (board[index - BOXES_IN_EACH_ROW][0] == 0 &&
              board[index - BOXES_IN_EACH_ROW][1] == false) {
            revealBox(index - BOXES_IN_EACH_ROW);
          }
          board[index - BOXES_IN_EACH_ROW][1] = true;
        }

        // reveal top right box
        if (index >= BOXES_IN_EACH_ROW &&
            index % BOXES_IN_EACH_ROW != BOXES_IN_EACH_ROW - 1) {
          if (board[index + 1 - BOXES_IN_EACH_ROW][0] == 0 &&
              board[index + 1 - BOXES_IN_EACH_ROW][1] == false) {
            revealBox(index + 1 - BOXES_IN_EACH_ROW);
          }
          board[index + 1 - BOXES_IN_EACH_ROW][1] = true;
        }

        // reveal left box
        if (index % BOXES_IN_EACH_ROW != 0) {
          if (board[index - 1][0] == 0 && board[index - 1][1] == false) {
            revealBox(index - 1);
          }
          board[index - 1][1] = true;
        }

        // reveal right box
        if (index % BOXES_IN_EACH_ROW != BOXES_IN_EACH_ROW - 1) {
          if (board[index + 1][0] == 0 && board[index + 1][1] == false) {
            revealBox(index + 1);
          }
          board[index + 1][1] = true;
        }

        // reveal bottom left box
        if (index < NUMBER_OF_BOXES - BOXES_IN_EACH_ROW &&
            index % BOXES_IN_EACH_ROW != 0) {
          if (board[index - 1 + BOXES_IN_EACH_ROW][0] == 0 &&
              board[index - 1 + BOXES_IN_EACH_ROW][1] == false) {
            revealBox(index - 1 + BOXES_IN_EACH_ROW);
          }
          board[index - 1 + BOXES_IN_EACH_ROW][1] = true;
        }

        // reveal bottom box
        if (index < NUMBER_OF_BOXES - BOXES_IN_EACH_ROW) {
          if (board[index + BOXES_IN_EACH_ROW][0] == 0 &&
              board[index + BOXES_IN_EACH_ROW][1] == false) {
            revealBox(index + BOXES_IN_EACH_ROW);
          }
          board[index + BOXES_IN_EACH_ROW][1] = true;
        }

        // reveal bottom right box
        if (index < NUMBER_OF_BOXES - BOXES_IN_EACH_ROW &&
            index % BOXES_IN_EACH_ROW != BOXES_IN_EACH_ROW - 1) {
          if (board[index + 1 + BOXES_IN_EACH_ROW][0] == 0 &&
              board[index + 1 + BOXES_IN_EACH_ROW][1] == false) {
            revealBox(index + 1 + BOXES_IN_EACH_ROW);
          }
          board[index + 1 + BOXES_IN_EACH_ROW][1] = true;
        }
      });
    }
  }

  void scanBombs() {
    for (int i = 0; i < NUMBER_OF_BOXES; i++) {
      int bombsAround = 0;

      // check box to the top left
      if (i % BOXES_IN_EACH_ROW != 0 &&
          i >= BOXES_IN_EACH_ROW &&
          bombsLocation.contains(i - 1 - BOXES_IN_EACH_ROW)) {
        bombsAround++;
      }

      // check box to the top
      if (i >= BOXES_IN_EACH_ROW &&
          bombsLocation.contains(i - BOXES_IN_EACH_ROW)) {
        bombsAround++;
      }

      // check box to the top right
      if (i % BOXES_IN_EACH_ROW != BOXES_IN_EACH_ROW - 1 &&
          i >= BOXES_IN_EACH_ROW &&
          bombsLocation.contains(i + 1 - BOXES_IN_EACH_ROW)) {
        bombsAround++;
      }

      // check box to the left
      if (i % BOXES_IN_EACH_ROW != 0 && bombsLocation.contains(i - 1)) {
        bombsAround++;
      }

      // check box to the right
      if (i % BOXES_IN_EACH_ROW != BOXES_IN_EACH_ROW - 1 &&
          bombsLocation.contains(i + 1)) {
        bombsAround++;
      }

      // check box to the bottom left
      if (i % BOXES_IN_EACH_ROW != 0 &&
          i < NUMBER_OF_BOXES - BOXES_IN_EACH_ROW &&
          bombsLocation.contains(i - 1 + BOXES_IN_EACH_ROW)) {
        bombsAround++;
      }

      // check box to the bottom
      if (i < NUMBER_OF_BOXES - BOXES_IN_EACH_ROW &&
          bombsLocation.contains(i + BOXES_IN_EACH_ROW)) {
        bombsAround++;
      }

      // check box to the bottom right
      if (i % BOXES_IN_EACH_ROW != BOXES_IN_EACH_ROW - 1 &&
          i < NUMBER_OF_BOXES - BOXES_IN_EACH_ROW &&
          bombsLocation.contains(i + 1 + BOXES_IN_EACH_ROW)) {
        bombsAround++;
      }

      setState(() {
        board[i][0] = bombsAround;
      });
    }
  }

  void restartGame() {
    // initialize bombsLocation
    bombsLocation.clear();
    for (int i = 0; i < NUMBER_OF_BOMBS; i++) {
      int randomIndex = (Random()).nextInt(NUMBER_OF_BOXES);
      while (bombsLocation.contains(randomIndex)) {
        randomIndex = (Random()).nextInt(NUMBER_OF_BOXES);
      }
      bombsLocation.add(randomIndex);
    }

    for (int i = 0; i < NUMBER_OF_BOXES; i++) {
      board[i][1] = false;
    }

    scanBombs();

    // number of bombs around needs to be != 0
    bombsLocation.forEach((index) {
      board[index][0] = 9;
    });

    time = const Duration();
    setState(() {
      win = false;
      timer?.cancel();
    });
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(
        () {
          final seconds = time.inSeconds + 1;
          time = Duration(seconds: seconds);
        },
      );
    });
  }

  String formatDate() {
    DateTime today = DateTime.now();
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return "${today.day.toString()} ${months[today.month - 1]} ${today.year.toString()}/";
  }

  String formatTime() {
    String seconds = "", minutes = "", hours = "";

    if (time.inHours != 0) {
      hours = "${time.inHours}H ";
      minutes = "${time.inMinutes.remainder(60)}M ";
      seconds = "${time.inSeconds.remainder(60)}S";
    } else if (time.inMinutes.remainder(60) != 0) {
      minutes = "${time.inMinutes.remainder(60)}M ";
      seconds = "${time.inSeconds.remainder(60)}S";
    } else {
      seconds = "${time.inSeconds.remainder(60)}S";
    }

    return hours + minutes + seconds;
  }

  Future<List<String>> appendTimesList(String time) async {
    final prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList("times");

    list ??= [];
    list.add(time);
    await prefs.setStringList("times", list);
    return list;
  }

  int timeToSeconds(String time) {
    int seconds = 0;
    List<String> subStrings = time.split(" ");
    int multiplier = 1;

    subStrings.reversed.forEach((str) {
      seconds += int.parse(str.substring(0, str.length - 1)) * multiplier;
      multiplier *= 60;
    });

    return seconds;
  }

  List<Widget> buildTimes(List<String> times) {
    int index = -1;
    String last = times.last;

    times.sort(((a, b) => timeToSeconds(a.split("/")[1])
        .compareTo(timeToSeconds(b.split("/")[1]))));
    times = times.take(10).toList();
    int lastIndex = times.indexOf(last);

    return times.map((time) {
      index++;
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Container(
          color: index == lastIndex ? myPrimaryColor : myBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 3, right: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${index + 1}. ${time.split("/")[0]}",
                  style: TextStyle(
                      color: index == lastIndex
                          ? myBackgroundColor
                          : Colors.white),
                ),
                Text(
                  time.split("/")[1],
                  style: TextStyle(
                      color: index == lastIndex
                          ? myBackgroundColor
                          : Colors.white),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  void won() {
    setState(() {
      timer?.cancel();
      win = true;
    });
    revealBombs();
    appendTimesList(formatDate() + formatTime()).then((times) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: mySecondaryColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: myBackgroundColor,
              title: const Center(
                child: Text("WIN!", style: TextStyle(color: Colors.white)),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: buildTimes(times),
              ),
              actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: myBackgroundColor,
                                side: const BorderSide(
                                    color: mySecondaryColor, width: 1),
                              ),
                              onPressed: () {
                                restartGame();
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Start new game",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: myBackgroundColor,
                                side: const BorderSide(
                                    color: mySecondaryColor, width: 1),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Quit",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          });
    });
  }

  void lost() {
    setState(() {
      timer?.cancel();
    });
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: mySecondaryColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: myBackgroundColor,
            title: const Center(
              child: Text("BOOM!", style: TextStyle(color: Colors.white)),
            ),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: myBackgroundColor,
                              side: const BorderSide(
                                  color: mySecondaryColor, width: 1),
                            ),
                            onPressed: () {
                              restartGame();
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Start new game",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: myBackgroundColor,
                              side: const BorderSide(
                                  color: mySecondaryColor, width: 1),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Quit",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
