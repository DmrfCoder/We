// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeLineModelList _$TimeLineModelListFromJson(Map<String, dynamic> json) {
  return TimeLineModelList((json['list'] as List)
      ?.map((e) =>
          e == null ? null : TimelineModel.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$TimeLineModelListToJson(TimeLineModelList instance) =>
    <String, dynamic>{'list': instance.list};
