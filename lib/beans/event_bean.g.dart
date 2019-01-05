// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineModel _$TimelineModelFromJson(Map<String, dynamic> json) {
  return TimelineModel(
      time: json['time'] as String,
      editbeanList: json['editbeanList'] == null
          ? null
          : EditbeanList.fromJson(json['editbeanList'] as Map<String, dynamic>),
      id: json['id'] as String,
      messageType: json['messageType'])
    ..isOther = json['isOther'] as bool;
}

Map<String, dynamic> _$TimelineModelToJson(TimelineModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'editbeanList': instance.editbeanList,
      'id': instance.id,
      'messageType': _$MessageTypeEnumMap[instance.messageType],
      'isOther': instance.isOther
    };

const _$MessageTypeEnumMap = <MessageType, dynamic>{
  MessageType.nice: 'nice',
  MessageType.bad: 'bad'
};
