import 'package:flutter_we/beans/edit_bean.dart';

class EditbeanList {
  List<EditBean> list;
  int index;

  EditbeanList() {
    list = new List();
    index = 0;
  }

  addEditBean(var source) {
    if (source == Null) {
      EditBean editBean = new EditBean(index++, false, null, null);
      list.add(editBean);
    } else if (source is String) {
      EditBean editBean = new EditBean(index++, true, source, null);
      list.add(editBean);
    } else {
      EditBean editBean = new EditBean(index++, false, null, source);
      list.add(editBean);
    }
  }
}
