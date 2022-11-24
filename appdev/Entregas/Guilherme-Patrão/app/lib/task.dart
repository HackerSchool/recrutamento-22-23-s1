// ignore_for_file: prefer_typing_uninitialized_variables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:todo_list/util.dart';
import 'package:todo_list/task_object.dart';

class Task extends StatelessWidget {
	final TaskObject taskObj;
  	final onCompleted;
  	final onMarkAsUrgent;
	final onDeleteTask;

  	const Task({
    	Key? key,
    	required this.taskObj,
    	required this.onCompleted,
    	required this.onMarkAsUrgent,
		required this.onDeleteTask,
  	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Column(
			children: [ 
				ListTile(
					onTap: (){
						onCompleted(taskObj);
					},
					shape: BeveledRectangleBorder(
						borderRadius: BorderRadius.circular(5)
					),
					tileColor: frost,
					leading: checkIsCompleted(taskObj),
					title: Text(taskObj.description, style: const TextStyle(color: Colors.black, fontSize: 21),),
					trailing: Row(
                    	mainAxisSize: MainAxisSize.min,
                    	children: [
                      		IconButton( icon: checkUrgentStatus(taskObj),
                        	onPressed: () {
                          		onMarkAsUrgent(taskObj);
                        	},
                      		),
                      		IconButton( icon: const Icon(Icons.delete_forever),
                        	onPressed: () {
                          		onDeleteTask(taskObj);
                        	},
                      		),
                    	],
                  ),
				),
				const SizedBox(height: 25),
			],
		);
	}

	Icon checkIsCompleted(TaskObject to){
		if(to.isCompleted){
			return const Icon(Icons.check_box, color: Colors.black);
		} 

		return const Icon(Icons.check_box_outline_blank, color: Colors.black);
	}

	Icon checkUrgentStatus(TaskObject to){
		if(to.isUrgent){
			return const Icon(Icons.access_time_filled);
		}

		return const Icon(Icons.access_time);
	}
}