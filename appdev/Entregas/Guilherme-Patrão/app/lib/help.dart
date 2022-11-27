import 'package:flutter/material.dart';
import 'package:todo_list/util.dart';

class Help extends StatefulWidget {
	const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => HelpState();
}

class HelpState extends State<Help> {

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
						handleTitle(), 
					],
				)
			)
		
		);
  	}

	AppBar handleAppBar(BuildContext context){
		return AppBar(
				backgroundColor: purple,
				elevation: 0.1
			);
	}

	Expanded handleTitle(){

    	return Expanded(
							child: ListView(
							children: [
								Container(
									margin: const EdgeInsets.only(top:50, bottom:20),
									child: const Text("How to Use", style: TextStyle(fontSize:35 , fontWeight: FontWeight.w500))
								),
								Container(
									margin: const EdgeInsets.only(top: 10, bottom: 20),
									child: const Text("This is a ToDo List app. Its objective is to provide a simple UI to help you keep track of the tasks you have to do.", 
										style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
								),
								Container(
									margin: const EdgeInsets.only(top: 10, bottom: 20),
									child: const Text("To add a task, simply write the task description on the bottom rectangle and then click the '+' button.\n\nAfter adding tasks, you can now mark/unmark them as done, mark/unmark them as urgent or remove them.\n\nTo mark/unmark a tasks as urgent, click on the clock icon in the right side of the task you wish to do this on. A filled clock indicates the task is urgent and an unfilled clock indicates the task is not urgent.\n\nTo remove a task, simply click on the delete button in the right side of the task you wish to remove.\n\nIf you wish to only see which of your tasks are marked as urgent, you can click on the top left icon of the home page to turn on the filter.",
										style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300))
								)
							],
							)
						);
  	}
}