import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:json_annotation/json_annotation.dart';

void main() {
  runApp(const MyApp());
}

CalendarFormat _calendarFormat = CalendarFormat.month;

//Event Class
@JsonSerializable()
class DateEvents {
  String title;
  String details;
  String type;

  DateEvents({required this.title, required this.details, required this.type});

  factory DateEvents.fromJson(dynamic json) {
    return DateEvents(
        title: json['title'] as String,
        details: json['details'] as String,
        type: json['type'] as String);
  }

  Map toJson() => {
        'title': title,
        'details': details,
        'type': type,
      };
}

//Encode Map of Events to JSON
Map<String, dynamic> encodeMap(Map<DateTime, List<DateEvents>> map) {
  Map<String, dynamic> newMap = {};
  map.forEach((key1, value1) {
    newMap[key1.toString()] = jsonEncode(map[key1]);
  });
  return newMap;
}

//Decode Map of Events from JSON
Map<DateTime, List<DateEvents>> decodeMap(Map<String, dynamic> map) {
  Map<DateTime, List<DateEvents>> newMap = {};
  map.forEach((key1, value1) {
    var eventsJson = jsonDecode(value1) as List;
    newMap[DateTime.parse(key1)] =
        eventsJson.map((event) => DateEvents.fromJson(event)).toList();
  });
  return newMap;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HS Calendar',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'HS - Calendar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;
  late final ValueNotifier<List<DateEvents>> _selectedEvents;
  Map<DateTime, List<DateEvents>> _eventsMap = {};

  //Checkboxes Values
  bool _tasks = true;
  bool _events = true;
  bool _reminders = true;

  Map<String, Color?> eventTypeColor = {
    "Event": Colors.green,
    "Reminder": const Color.fromRGBO(33, 53, 2, 1.0),
    "Task": const Color.fromRGBO(2, 82, 92, 1)
  };

  Future<void> prefsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _eventsMap = Map<DateTime, List<DateEvents>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  //Runs whenever we add a event and adds the event to the map of events, tries to save it to the preferences too
  Future<void> _awaitReturnValueFromSecondScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddEventPage(),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    if (_eventsMap[_selectedDay] != null) {
      setState(() {
        _eventsMap[_selectedDay]!.add(result);
      });
    } else {
      setState(() {
        _eventsMap[_selectedDay] = [result];
      });
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("events", json.encode(encodeMap(_eventsMap)));
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
    prefsData();
  }

  List<DateEvents> _getEventsForDay(DateTime day) {
    var e = _eventsMap[day] ?? [];
    List<DateEvents> eventList = [];
    for (var i = 0; i < e.length; i++) {
      if ((e[i].type == "Event") & (_events)) {
        eventList.add(e[i]);
      } else if ((e[i].type == "Task") & (_tasks)) {
        eventList.add(e[i]);
      } else if ((e[i].type == "Reminder") & (_reminders)) {
        eventList.add(e[i]);
      }
    }
    return eventList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            tooltip: 'Info',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text(
                        "Welcome! This calendar is my app for the AppDev Project.\n\n In this app, you can add events to a determined day and give them a title, a type and details, as usual in your typical calendar. To do that just click on the plus sign in the bottom right of the app, there you'll have more instructions!\n\n If you click on the three bars on the left, a sidebar menu will open and there you can choose your calendar display. Besides that you'll also be able to choose what type of events will appear on the calendar!"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"))
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TableCalendar(
                firstDay: DateTime.utc(1900, 1, 1),
                lastDay: DateTime.utc(2200, 12, 31),
                eventLoader: _getEventsForDay,
                calendarStyle: CalendarStyle(
                  canMarkersOverflow: true,
                  todayDecoration: BoxDecoration(
                      color: Colors.green.shade300, shape: BoxShape.circle),
                  selectedDecoration: BoxDecoration(
                      color: Colors.green.shade800, shape: BoxShape.circle),
                  todayTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white),
                ),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: ((
                  selectedDay,
                  focusedDay,
                ) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  _selectedEvents.value = _getEventsForDay(selectedDay);
                }),
                headerStyle: const HeaderStyle(
                    titleCentered: true, formatButtonVisible: false),
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              )),
          //All events containers
          ..._getEventsForDay(_selectedDay).map(
            (event) => Container(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                trailing: OutlinedButton(
                  child: const Icon(
                    Icons.clear_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    setState(() {
                      _eventsMap[_selectedDay]!.remove(event);
                    });
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString(
                        "events", json.encode(encodeMap(_eventsMap)));
                  },
                ),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                tileColor: eventTypeColor[event.type],
                leading: const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Icon(
                    Icons.bookmark,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  event.title,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                subtitle: Text(event.details,
                    style: const TextStyle(color: Colors.white)),
              ),
            ),
          )
        ],
      )),

      //Add event button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _awaitReturnValueFromSecondScreen(context);
        },
        tooltip: 'Add Events',
        child: const Icon(Icons.add),
      ),
      //Sidebar
      drawer: Drawer(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                color: Colors.green,
                padding: EdgeInsets.only(
                    top: 16 + MediaQuery.of(context).padding.top, bottom: 16),
                child: const Center(
                  child: Text(
                    "HS - Calendar",
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  ),
                )),
            Container(
                padding: const EdgeInsets.all(5),
                child: Wrap(runSpacing: 16, children: [
                  ListTile(
                    leading: const Icon(Icons.calendar_view_week_outlined),
                    title: const Text("Week"),
                    onTap: () {
                      setState(() {
                        _calendarFormat = CalendarFormat.week;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_view_month_outlined),
                    title: const Text("Month"),
                    onTap: () {
                      setState(() {
                        _calendarFormat = CalendarFormat.month;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(
                    color: Colors.black54,
                    thickness: 1.0,
                  ),
                  CheckboxListTile(
                    title: const Text("Events"),
                    value: _events,
                    activeColor: eventTypeColor["Event"],
                    onChanged: (bool? value) {
                      setState(() {
                        _events = value ?? _events;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Tasks"),
                    value: _tasks,
                    activeColor: eventTypeColor["Task"],
                    onChanged: (bool? value) {
                      setState(() {
                        _tasks = value ?? _tasks;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Reminders"),
                    value: _reminders,
                    activeColor: eventTypeColor["Reminder"],
                    onChanged: (bool? value) {
                      setState(() {
                        _reminders = value ?? _reminders;
                      });
                    },
                  )
                ])),
          ],
        )),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//Second Screen
class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPage();
}

class _AddEventPage extends State<AddEventPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  String _eventType = "Event";

  var eventOptions = ["Event", "Task", "Reminder"];

  //Sends event back to first screen as the wanted object
  void _sendDataBack(BuildContext context) {
    String title = titleController.text;
    String details = detailController.text;
    if (details == "") {
      details = "...";
    }
    final event = DateEvents(title: title, details: details, type: _eventType);
    Navigator.pop(context, event);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Event"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            tooltip: "Go Back",
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.info_outline_rounded),
              tooltip: 'Info',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Info"),
                      content: const Text(
                          "To add an event just write some title, choose your event type, and write some details about it if you want! After all that just click on the check mark and you'll be all set!"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("OK"))
                      ],
                    );
                  },
                );
              },
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      hintText: "Event Title",
                      border: UnderlineInputBorder(),
                      hintStyle: TextStyle(fontSize: 30, color: Colors.grey)),
                  style: TextStyle(fontSize: 30, color: Colors.green[600]),
                  controller: titleController,
                )),
            Container(
                padding: const EdgeInsets.all(5),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_month_outlined)),
                  value: _eventType,
                  items: eventOptions.map((String eventOptions) {
                    return DropdownMenuItem(
                        value: eventOptions, child: Text(eventOptions));
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _eventType = newValue!;
                    });
                  },
                )),
            Container(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.not_listed_location_outlined),
                      hintText: "Details",
                      border: UnderlineInputBorder(),
                      hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
                  style: const TextStyle(fontSize: 15),
                  controller: detailController,
                ))
          ],
        ),
        //Sends us back to the first screen
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _sendDataBack(context);
          },
          tooltip: 'Add Event',
          child: const Icon(Icons.check),
        ));
  }
}
