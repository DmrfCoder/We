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
  UpdateData updateData;


  EditorControllor() {
    _editbeanList = new EditbeanList();

    _editbeanList.addEditBean("test1");
    _editbeanList.addEditBean(Null);
    _editbeanList.addEditBean("test2");
    _editbeanList.addEditBean(Null);

    _editbeanList.addEditBean("test3");
  }

  EditbeanList get editbeanList => _editbeanList;

  set editbeanList(EditbeanList value) {
    _editbeanList = value;
  }

  deleteIndex(int index, ImageWidgetState state) {
    if (index < 0 || index > _editbeanList.list.length) {
      return false;
    } else {
      _editbeanList.list.removeAt(index);
      print('delete');

      state.updateData();
    }
  }
}
