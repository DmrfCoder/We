import 'package:flutter_we/beans/edit_bean.dart';

abstract class AddProjectPageCallBack {
  deleteEditbean(EditBean editbean);

  updateEditbean(EditBean editbean);

  updateCurEditbean(EditBean curEditbean);
}
