import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_bean.g.dart';

@JsonSerializable()
class EditBean {
  int index;
  bool isText;
  String content;

  EditBean(this.index, this.isText, this.content);

  updateIndex() {
    index++;
  }

  factory EditBean.fromJson(Map<String, dynamic> json) =>
      _$EditBeanFromJson(json);

  Map<String, dynamic> toJson() => _$EditBeanToJson(this);
}
