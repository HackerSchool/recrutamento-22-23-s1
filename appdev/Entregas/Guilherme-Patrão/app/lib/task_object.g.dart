// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskObject _$TaskObjectFromJson(Map<String, dynamic> json) => TaskObject(
      id: json['id'] as int,
      description: json['description'] as String,
      isUrgent: json['isUrgent'] as bool? ?? false,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$TaskObjectToJson(TaskObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'isUrgent': instance.isUrgent,
      'isCompleted': instance.isCompleted,
    };
