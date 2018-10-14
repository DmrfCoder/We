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
      title: json['title'] as String,
      id: json['id'] as String);
}

Map<String, dynamic> _$TimelineModelToJson(TimelineModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'editbeanList': instance.editbeanList,
      'title': instance.title,
      'id': instance.id
    };
