// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_work_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToDoWorkBean _$ToDoWorkBeanFromJson(Map<String, dynamic> json) {
  return ToDoWorkBean(json['year'] as int, json['month'] as int,
      json['day'] as int, json['content'] as String, json['userId'] as String);
}

Map<String, dynamic> _$ToDoWorkBeanToJson(ToDoWorkBean instance) =>
    <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
      'content': instance.content,
      'userId': instance.userId
    };
