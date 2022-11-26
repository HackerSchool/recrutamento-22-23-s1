import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "game.dart";

const myBackgroundColor = Color(0xff181b22);
const mySecondaryColor = Color(0xff404558);

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  List<String> times = [];

  @override
  void initState() {
    super.initState();
    updateTimes();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(Image.asset("assets/logo-primary.png").image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/logo-primary.png",
              height: 200,
              filterQuality: FilterQuality.medium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(60),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Game()),
                          );
                        },
                        child: const Text(
                          "Start new game",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
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
                          updateTimes();
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
                                    child: Text("Times",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: buildTimes(),
                                  ),
                                  actions: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              child: OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    backgroundColor:
                                                        myBackgroundColor,
                                                    side: const BorderSide(
                                                        color: mySecondaryColor,
                                                        width: 1),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    "Close",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: const Text(
                          "Times",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
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
                                  title: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 25,
                                          child: Image.asset(
                                            "assets/logo-primary.png",
                                            height: 200,
                                            filterQuality: FilterQuality.medium,
                                          ),
                                        ),
                                        const Text(" Minesweeper",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                  content: const Text(
                                    "The board is divided into cells, with mines randomly distributed. To win, you need to open all the safe cells. The number on a cell shows the number of mines adjacent to it. Using this information, you can determine cells that are safe, and cells that contain mines.\n\nTo start a new game, you can click on the refresh icon at the top of the board. The number of mines and the game timer are also displayed at the top of the board.",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.justify,
                                  ),
                                  actions: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              child: OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    backgroundColor:
                                                        myBackgroundColor,
                                                    side: const BorderSide(
                                                        color: mySecondaryColor,
                                                        width: 1),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    "Close",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: const Text(
                          "Rules",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<List<String>> getTimesList() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList("times");

    if (list == null) {
      return [];
    } else {
      return list;
    }
  }

  void updateTimes() {
    setState(() {
      getTimesList().then((list) {
        times = list;
        times.sort(((a, b) => timeToSeconds(a.split("/")[1])
            .compareTo(timeToSeconds(b.split("/")[1]))));
        times = times.take(20).toList();
      });
    });
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

  List<Widget> buildTimes() {
    int index = 1;

    if (times.isEmpty) {
      return [
        const Text("No times yet.", style: TextStyle(color: Colors.white))
      ];
    }

    return times.map((time) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${index++}. ${time.split("/")[0]}",
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              time.split("/")[1],
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }).toList();
  }
}
