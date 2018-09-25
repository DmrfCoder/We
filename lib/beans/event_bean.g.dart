// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineModel _$TimelineModelFromJson(Map<String, dynamic> json) {
  return TimelineModel(json['time'] as String, json['description'] as String,
      json['title'] as String);
}

Map<String, dynamic> _$TimelineModelToJson(TimelineModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'description': instance.description,
      'title': instance.title
    };
