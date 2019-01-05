import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'todo_work_bean.g.dart';

@JsonSerializable()
class ToDoWorkBean {
  int year;
  int month;
  int day;
  String content;
  String userId;

  ToDoWorkBean(this.year, this.month, this.day, this.content, this.userId);

  factory ToDoWorkBean.fromJson(Map<String, dynamic> json) =>
      _$ToDoWorkBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ToDoWorkBeanToJson(this);
}
