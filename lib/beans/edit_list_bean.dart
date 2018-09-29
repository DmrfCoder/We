import 'dart:io';

import 'package:flutter_we/beans/edit_bean.dart';

class EditbeanList {
  List<EditBean> list;

  EditbeanList() {
    list = new List();
  }

  addEditBean(var source, int curIndex) {
    if (source is String) {
      EditBean editBean = new EditBean(curIndex, true, source, null);
      list.add(editBean);
      return false;
    } else if (source is File) {
      EditBean editBean = new EditBean(curIndex, false, null, source);

      if (curIndex == list.length) {
        _insertImageToList(curIndex, editBean);
        return true;
      } else {
        _insertImageToList(curIndex, editBean);
        return false;
      }
    }
  }

  _insertImageToList(int curIndex, EditBean editBean) {
    list.insert(curIndex, editBean);
    for (int i = curIndex + 1; i < list.length; i++) {
      list[i].updateIndex();
    }
  }
}
