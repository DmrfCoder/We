import 'dart:io';

import 'package:flutter_we/beans/edit_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_list_bean.g.dart';

@JsonSerializable()
class EditbeanList {
  List<EditBean> list;

  EditbeanList() {
    list = new List();
  }

  addEditBean(var source, int curIndex, bool istext) {
    EditBean editBean = new EditBean(curIndex, istext, source);

    if (curIndex == list.length) {
      list.add(editBean);
      return true;
    } else {
      _insertImageToList(curIndex, editBean);
      return false;
    }
  }

  _insertImageToList(int curIndex, EditBean editBean) {
    list.insert(curIndex, editBean);
    for (int i = curIndex + 1; i < list.length; i++) {
      list[i].updateIndex();
    }
  }

  factory EditbeanList.fromJson(Map<String, dynamic> json) =>
      _$EditbeanListFromJson(json);

  Map<String, dynamic> toJson() => _$EditbeanListToJson(this);
}
