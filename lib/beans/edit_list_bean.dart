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

    if(curIndex==list.length){
      EditBean editBean2 = new EditBean(curIndex, true, "");
      list.add(editBean2);
      return curIndex;
    }

    int insertIndex = curIndex + 1;

    EditBean editBean = new EditBean(insertIndex, istext, source);




    if (insertIndex == list.length) {
      list.add(editBean);
      EditBean editBean2 = new EditBean(insertIndex + 1, true, "");
      list.add(editBean2);

      return insertIndex + 1;
    } else if (list[insertIndex].isText) {
      _insertImageToList(insertIndex, editBean);
      return insertIndex + 1;
    } else {
      _insertImageToList(insertIndex, editBean);

      for (int start = insertIndex; start < list.length; start++) {
        if (list[start].isText) {
          return start;
        }
      }

      EditBean editBean3 = new EditBean(insertIndex + 1, true, "");
      list.add(editBean3);
      return list.length - 1;
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
