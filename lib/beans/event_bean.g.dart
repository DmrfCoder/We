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
      messageType:
          _$enumDecodeNullable(_$MessageTypeEnumMap, json['messageType']));
}

Map<String, dynamic> _$TimelineModelToJson(TimelineModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'editbeanList': instance.editbeanList,
      'id': instance.id,
      'messageType': _$MessageTypeEnumMap[instance.messageType]
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$MessageTypeEnumMap = <MessageType, dynamic>{
  MessageType.nice: 'nice',
  MessageType.bad: 'bad'
};
