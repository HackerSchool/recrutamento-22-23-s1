import 'package:flutter/material.dart';
import 'package:todo_list/util.dart';
import 'package:todo_list/task_object.dart';
import 'package:todo_list/task.dart';

class Urgent extends StatefulWidget {
	const Urgent({Key? key}) : super(key: key);

  @override
  State<Urgent> createState() => UrgentState();
}

class UrgentState extends State<Urgent> {

  	@override
  	void initState() {
    	super.initState();
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
					],
				)
			)
		
		);
  	}

	AppBar handleAppBar(BuildContext context){
		return AppBar(
				backgroundColor: purple,
				elevation: 0.1,
				title: Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
					Icon(
						Icons.help_rounded,
						color: Colors.black,
						size: 25,
					)
				])
			);
	}

	Expanded handleTaskList(){

		final urgentTaskList = TaskObject.urgentTaskList();

    	return Expanded(
							child: ListView(
							children: [
								Container(
									margin: const EdgeInsets.only(top:50, bottom:20),
									child: const Text("Urgent Tasks", style: TextStyle(fontSize:35 , fontWeight: FontWeight.w500))
								),
								for (TaskObject t in urgentTaskList)
									Task(
										taskObj: t, 
										onCompleted: doNothing, 
										onMarkAsUrgent: doNothing,
										onDeleteTask: doNothing,
									),
							],
							)
						);
  	}

	void doNothing(TaskObject to){
		// literally doesn't do anything, who would've guessed...
	}
}