import 'package:event_bus/event_bus.dart';
import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/beans/edit_bean.dart';
import 'package:flutter_we/beans/edit_list_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_bean.g.dart';

@JsonSerializable()
class TimelineModel {
  String time;

  EditbeanList editbeanList;

  String id = "-1";

  MessageType messageType;

  bool isOther=false;

  bool inServer=false;

  getLength() {
    return editbeanList.list.length;
  }

  TimelineModel({this.time, this.editbeanList, this.id, messageType}) {
    if (this.editbeanList == null) {
      this.editbeanList = new EditbeanList();
    }

    if (messageType is MessageType) {
      this.messageType = messageType;
      return;
    }

    switch (messageType) {
      case 0:
        this.messageType = MessageType.nice;
        break;
      case 1:
        this.messageType = MessageType.bad;
        break;
    }
  }

  factory TimelineModel.fromJson(Map<String, dynamic> json) =>
      _$TimelineModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimelineModelToJson(this);

  void clear() {
    editbeanList.list = [];
  }

  void removeAt(int index) {
    editbeanList.list.removeAt(index);
  }

  void setData(int index, EditBean editbean) {
    editbeanList.list[index] = editbean;
  }
}
