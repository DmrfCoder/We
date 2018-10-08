// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineModel _$TimelineModelFromJson(Map<String, dynamic> json) {
  return TimelineModel(
      json['time'] as String,
      json['editbeanList'] == null
          ? null
          : EditbeanList.fromJson(json['editbeanList'] as Map<String, dynamic>),
      json['title'] as String)
    ..id = json['id'] as int;
}

Map<String, dynamic> _$TimelineModelToJson(TimelineModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'editbeanList': instance.editbeanList,
      'title': instance.title,
      'id': instance.id
    };
