import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_we/beans/edit_bean.dart';
import 'package:flutter_we/beans/edit_list_bean.dart';
import 'package:flutter_we/widgets/image_widget.dart';
import 'package:path/path.dart';

abstract class UpdateData {
  void updateData();
}

class EditorControllor {
  EditbeanList _editbeanList;

  int _curIndex;

  int get curIndex => _curIndex;

  set curIndex(int value) {
    _curIndex = value;
  }

  EditorControllor() {
    _editbeanList = new EditbeanList();
    _curIndex = 0;

    _editbeanList.addEditBean("", _curIndex);
  }

  EditbeanList get editbeanList => _editbeanList;

  set editbeanList(EditbeanList value) {
    _editbeanList = value;
  }

  deleteIndex(int index, var state) {
    if (index < 0 || index > _editbeanList.list.length) {
      return false;
    } else {
      _editbeanList.list.removeAt(index);
      print('delete');

      state.updateData();
    }
  }

  addPicture(File file) {
    if (_editbeanList.addEditBean(file, _curIndex+1)) {
      _curIndex++;
      _editbeanList.addEditBean("", _curIndex);
    }
  }
}
