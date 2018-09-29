import 'dart:io';

import 'package:flutter_we/beans/edit_bean.dart';

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
}
