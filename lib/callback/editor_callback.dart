import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/beans/edit_bean.dart';

abstract class EditorCallBack {
  updateEditBeanData({ChangeType changeType, EditBean editBean});

  updateCurIndex({EditBean CurEditBean});
}
