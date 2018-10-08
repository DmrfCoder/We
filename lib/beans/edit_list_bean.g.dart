// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditbeanList _$EditbeanListFromJson(Map<String, dynamic> json) {
  return EditbeanList()
    ..list = (json['list'] as List)
        ?.map((e) =>
            e == null ? null : EditBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$EditbeanListToJson(EditbeanList instance) =>
    <String, dynamic>{'list': instance.list};
