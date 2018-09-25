import 'package:event_bus/event_bus.dart';
import 'package:json_annotation/json_annotation.dart';
part 'event_bean.g.dart';
EventBus eventBus = new EventBus();

@JsonSerializable()
class TimelineModel {
  String time;

  String description;

  String title;




  factory TimelineModel.fromJson(Map<String,dynamic> json)=>_$TimelineModelFromJson(json);


  Map<String, dynamic> toJson() => _$TimelineModelToJson(this);

  TimelineModel(this.time, this.description, this.title);
}
