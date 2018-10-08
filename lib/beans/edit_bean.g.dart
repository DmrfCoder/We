// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditBean _$EditBeanFromJson(Map<String, dynamic> json) {
  return EditBean(
      json['index'] as int, json['isText'] as bool, json['content'] as String);
}

Map<String, dynamic> _$EditBeanToJson(EditBean instance) => <String, dynamic>{
      'index': instance.index,
      'isText': instance.isText,
      'content': instance.content
    };
