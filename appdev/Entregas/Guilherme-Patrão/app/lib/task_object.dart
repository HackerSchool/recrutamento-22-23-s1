import 'package:json_annotation/json_annotation.dart';

part 'task_object.g.dart';

@JsonSerializable()
class TaskObject {

	int id;
	String description;
	bool isUrgent;
	bool isCompleted;

	factory TaskObject.fromJson(Map<String, dynamic> json) => _$TaskObjectFromJson(json);
  	Map<String, dynamic> toJson() => _$TaskObjectToJson(this);

	static List<TaskObject> taskListAtt = [];
	
	static List<TaskObject> urgentTaskListAtt = [];

	TaskObject({
		required this.id,
		required this.description,
		this.isUrgent = false,
		this.isCompleted = false,
	});

	static List<TaskObject> taskList(){
		return taskListAtt;
	}

	static List<TaskObject> urgentTaskList(){
		return urgentTaskListAtt;
	}


}