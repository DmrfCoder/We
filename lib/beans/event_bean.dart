import 'package:event_bus/event_bus.dart';
import 'package:flutter_we/beans/edit_list_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_bean.g.dart';

EventBus eventBus = new EventBus();

@JsonSerializable()
class TimelineModel {
  String time;

  EditbeanList editbeanList;

  String title;

  String id = "-1";

  TimelineModel({this.time, this.editbeanList, this.title, this.id}) ;

  factory TimelineModel.fromJson(Map<String, dynamic> json) =>
      _$TimelineModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimelineModelToJson(this);
}
