// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:todo_list/task.dart';
import 'package:todo_list/util.dart';
import 'package:todo_list/task_object.dart';
import 'package:todo_list/urgent.dart';
import 'package:todo_list/help.dart';

import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class Core extends StatefulWidget {
  const Core({Key? key}) : super(key: key);

  @override
  State<Core> createState() => CoreState();
}

class CoreState extends State<Core> {

  late File jsonFile1;
  late File jsonFile2;
  late Directory dir;
  String fileName1 = "taskList.json";
  String fileName2 = "urgentTaskList.json";
  bool file1exists = false;
  bool file2exists = false;
  late String file1content;
  late String file2content;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile1 = new File(dir.path + "/" + fileName1);
      jsonFile2 = new File(dir.path + "/" + fileName2);
      file1exists = jsonFile1.existsSync();
      file2exists = jsonFile2.existsSync();
      if (file1exists) {
        file1content = jsonFile1.readAsStringSync();
        if (file1content.isNotEmpty) {
          this.setState(() => TaskObject.taskListAtt = (json
                  .decode(file1content) as List<dynamic>)
              .map(
                  (dynamic e) => TaskObject.fromJson(e as Map<String, dynamic>))
              .toList());
        }
      }
      if (file2exists) {
        file2content = jsonFile2.readAsStringSync();
        if (file2content.isNotEmpty) {
          this.setState(() => TaskObject.urgentTaskListAtt = (json
                  .decode(file2content) as List<dynamic>)
              .map(
                  (dynamic e) => TaskObject.fromJson(e as Map<String, dynamic>))
              .toList());
        }
      }
    });
  }

  void createFile() {
    File file1 = new File(dir.path + "/" + fileName1);
    File file2 = new File(dir.path + "/" + fileName2);
    file1.createSync();
    file2.createSync();
    file1exists = true;
    file2exists = true;
    file1.writeAsStringSync(json.encode(TaskObject.taskListAtt));
    file2.writeAsStringSync(json.encode(TaskObject.urgentTaskListAtt));
  }

  void writeToFile() {
    if (file1exists && file2exists) {
      file1content = jsonFile1.readAsStringSync();
      file2content = jsonFile2.readAsStringSync();
      if (file1content.isNotEmpty && file2content.isNotEmpty) {
        List<TaskObject> jsonFileContent1 = (json.decode(file1content)
                as List<dynamic>)
            .map((dynamic e) => TaskObject.fromJson(e as Map<String, dynamic>))
            .toList();
        List<TaskObject> toAdd = [];
        for (TaskObject to in TaskObject.taskListAtt) {
          if (!jsonFileContent1.contains(to)) {
            toAdd.add(to);
          }
        }
        jsonFile1.writeAsStringSync(json.encode(toAdd));

        List<TaskObject> jsonFileContent2 = (json.decode(file2content)
                as List<dynamic>)
            .map((dynamic e) => TaskObject.fromJson(e as Map<String, dynamic>))
            .toList();
        List<TaskObject> toAddu = [];
        for (TaskObject to in TaskObject.urgentTaskListAtt) {
          if (!jsonFileContent2.contains(to)) {
            toAddu.add(to);
          }
        }
        jsonFile2.writeAsStringSync(json.encode(toAddu));
      }
    } else {
      print("File does not exist!");
      createFile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: gray,
        appBar: handleAppBar(context),
        body: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 0,
            ),
            child: Column(
              children: [
                handleTaskList(),
                handleInput(),
              ],
            )));
  }

  AppBar handleAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: purple,
        elevation: 0.1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  openUrgentScreen(context);
                },
                icon: const Icon(Icons.access_time_filled_rounded,
                    color: Colors.black, size: 35)),
            IconButton(
                onPressed: () {
                  openHelpScreen(context);
                },
                icon: const Icon(Icons.help_rounded,
                    color: Colors.black, size: 25))
          ],
        ));
  }

  Expanded handleTaskList() {
    return Expanded(
        child: ListView(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 50, bottom: 20),
            child: const Text("All Tasks",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500))),
        for (TaskObject t in TaskObject.taskListAtt)
          Task(
            taskObj: t,
            onCompleted: handleCompleted,
            onMarkAsUrgent: handleMarkAsUrgent,
            onDeleteTask: handleDeleteTask,
          ),
      ],
    ));
  }

  Align handleInput() {
    final taskInput = TextEditingController();

    return Align(
        alignment: Alignment.bottomCenter,
        child: Row(children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                left: 15,
                right: 15,
                bottom: 50,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                controller: taskInput,
                decoration: const InputDecoration(
                    hintText: 'Add a new task', border: InputBorder.none),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 50, right: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: blue,
                minimumSize: const Size(50, 50),
                elevation: 3,
              ),
              onPressed: () {
                addTask(taskInput.text);
                taskInput.clear();
              },
              child: const Text("+"),
            ),
          )
        ]));
  }

  void handleCompleted(TaskObject to) {
    setState(() {
      if (to.isCompleted) {
        to.isCompleted = false;
        for (TaskObject t in TaskObject.urgentTaskList()) {
          if (t.id == to.id) {
            t.isCompleted = false;
          }
        }
      } else {
        to.isCompleted = true;
        for (TaskObject t in TaskObject.urgentTaskList()) {
          if (t.id == to.id) {
            t.isCompleted = true;
          }
        }
      }
      writeToFile();
    });
  }

  void handleMarkAsUrgent(TaskObject to) {
    setState(() {
      if (!to.isUrgent) {
        to.isUrgent = true;
        TaskObject.urgentTaskList().add(TaskObject(
            id: to.id,
            description: to.description,
            isUrgent: true,
            isCompleted: to.isCompleted));
        TaskObject.urgentTaskList().sort((a, b) => a.id.compareTo(b.id));
      } else {
        TaskObject temp = TaskObject(id: 999, description: "temp");
        bool found =
            false; // not really needed but if the impossible happens...
        for (TaskObject ut in TaskObject.urgentTaskList()) {
          if (ut.id == to.id) {
            found = true;
            temp = ut;
            break;
          }
        }
        if (found) {
          TaskObject.urgentTaskList().remove(temp);
        }
        to.isUrgent = false;
      }
      writeToFile();
    });
  }

  void handleDeleteTask(TaskObject to) {
    setState(() {
      TaskObject temp = TaskObject(id: 999, description: "temp");
      bool found = false;
      for (TaskObject t in TaskObject.taskList()) {
        if (t.id == to.id) {
          found = true;
          temp = t;
          break;
        }
      }
      if (found) {
        TaskObject.taskList().remove(temp);
      } else {
        print("not found... try again gorl");
      }
      found = false;
      for (TaskObject t in TaskObject.urgentTaskList()) {
        if (t.id == to.id) {
          found = true;
          temp = t;
          break;
        }
      }
      if (found) {
        TaskObject.urgentTaskList().remove(temp);
      }
      writeToFile();
    });
  }

  void addTask(String description) {
    TaskObject newTask = TaskObject(
      id: DateTime.now().millisecondsSinceEpoch,
      description: description,
    );
    setState(() {
      TaskObject.taskList().add(newTask);
      writeToFile();
    });
  }

  void openUrgentScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Urgent()),
    );
  }

  void openHelpScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Help()),
    );
  }
}
