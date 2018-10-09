import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/beans/edit_bean.dart';
import 'package:flutter_we/beans/edit_list_bean.dart';
import 'package:flutter_we/beans/event_bean.dart';
import 'package:flutter_we/callback/listview_item_click_callback.dart';
import 'package:flutter_we/pages/we_page.dart';
import 'package:flutter_we/widgets/image_widget.dart';
import 'package:flutter_we/widgets/text_widget.dart';
import 'package:path/path.dart';

class EditorControllor {
  EditbeanList _editbeanList;

  TimelineModel _timelineModel;

  var children;

  EditType _editType;

  EditType get editType => _editType;

  set editType(EditType value) {
    _editType = value;
  }

  set timelineModel(TimelineModel value) {
    _timelineModel = value;
    _editbeanList=_timelineModel.editbeanList;

  }

  int _curIndex;

  int get curIndex => _curIndex;

  updateCurEditbean(EditBean curEditbean) {
    int value = curEditbean.index;

    if (value < 0 || value >= _editbeanList.list.length) {
      return false;
    } else {
      _curIndex = value;
      return true;
    }
  }

  clear() {
    _editbeanList = null;
    _curIndex = 0;
  }

  EditorControllor() {
    _editbeanList = new EditbeanList();
    _curIndex = 0;
    children = <Widget>[];

    _editbeanList.addEditBean("", _curIndex, true);

    _editType = EditType.add;
  }

  EditbeanList get editbeanList => _editbeanList;

  set editbeanList(EditbeanList value) {
    _editbeanList = value;
  }

  deleteEditbean(EditBean editbean) {
    int index = editbean.index;
    if (index < 0 || index > _editbeanList.list.length) {
      return false;
    } else {
      _editbeanList.list.removeAt(index);
      print('delete');

      return true;
    }
  }

  updateEditbean(EditBean editbean) {
    int index = editbean.index;
    if (index < 0 || index > _editbeanList.list.length) {
      return false;
    } else {
      _editbeanList.list[index] = editbean;
      return true;
    }
  }

  addPicture(String strImage) {
    if (_editbeanList.addEditBean(strImage, _curIndex + 1, false)) {
      _curIndex++;
      _editbeanList.addEditBean("", _curIndex, true);
    }
  }

  dispose() {
    if (_editType == EditType.add) {
      DateTime now = new DateTime.now();
      String time = now.toString();
      time = time.substring(0, time.lastIndexOf(":"));

      TimelineModel timelineModel = new TimelineModel(
        time,
        editbeanList,
        "这是标题",
      );
      String js = json.encode(timelineModel);

      eventBus.fire(timelineModel);
    } else {
      _timelineModel.editbeanList = editbeanList;
      eventBus.fire(_timelineModel);
    }
  }
}
