import 'package:flutter_we/beans/event_bean.dart';
import 'package:json_annotation/json_annotation.dart';
part 'events_bean.g.dart';

@JsonSerializable()
class TimeLineModelList {
  List<TimelineModel> list;


  TimeLineModelList(this.list);

  factory TimeLineModelList.fromJson(Map<String, dynamic> json) =>
      _$TimeLineModelListFromJson(json);

  Map<String, dynamic> toJson() => _$TimeLineModelListToJson(this);
}
