import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/beans/edit_bean.dart';
import 'package:flutter_we/beans/edit_list_bean.dart';
import 'package:flutter_we/beans/event_bean.dart';
import 'package:flutter_we/callback/listview_item_click_callback.dart';
import 'package:flutter_we/callback/timelinemodeledit_callback.dart';
import 'package:flutter_we/pages/we_page.dart';
import 'package:flutter_we/widgets/image_widget.dart';
import 'package:flutter_we/widgets/text_widget.dart';
import 'package:path/path.dart';

class EditorControllor {
  TimelineModel _timelineModel;

  TimeLineModelEditCallBack _timeLineModelEditCallBack;

  List<Widget> children;

  EditType _editType;

  EditType get editType => _editType;

  getDataList(){
    return _timelineModel.editbeanList.list;
  }

  EditorControllor(this._timeLineModelEditCallBack, this._timelineModel) {
    _curIndex = 0;
    children = <Widget>[];

    _editType = EditType.add;
  }

  set editType(EditType value) {
    _editType = value;
    if (_editType == EditType.add) {
      EditBean editBean = new EditBean(_curIndex, true, "");
      _timelineModel.editbeanList.list.add(editBean);
      _timeLineModelEditCallBack.updateTimelineModel(_timelineModel);
    }
  }

  int _curIndex;

  int get curIndex => _curIndex;

  updateCurEditbean(EditBean curEditbean) {
    int value = curEditbean.index;

    if (value < 0 || value >= _timelineModel.getLength()) {
      return false;
    } else {
      _curIndex = value;
      return true;
    }
  }

  clear() {
    _timelineModel.clear();
    _curIndex = 0;
  }

  deleteEditbean(EditBean editbean) {
    int index = editbean.index;
    if (index < 0 || index > _timelineModel.getLength()) {
      return false;
    } else {
      _timelineModel.removeAt(index);
      print('delete');

      return true;
    }
  }

  updateEditbean(EditBean editbean) {
    int index = editbean.index;
    if (index < 0 || index >= _timelineModel.getLength()) {
      return false;
    } else {
      _timelineModel.setData(index, editbean);
      return true;
    }
  }

  addPicture(String strImage) {
    _curIndex =
        _timelineModel.editbeanList.addEditBean(strImage, _curIndex, false);
  }

  dispose() {
    List<EditBean> removeItems = [];

    for (EditBean editbeanItem in _timelineModel.editbeanList.list) {
      if (editbeanItem.isText) {
        if (editbeanItem.content.isEmpty) {
          print('remove empty widget in editor_controllor');
          removeItems.add(editbeanItem);
        }
      }
    }

    for (EditBean editbeanItem in removeItems) {
      _timelineModel.editbeanList.list.remove(editbeanItem);
    }

    bool emptyFlag = false;

    if (_timelineModel.getLength() == 0) {
      emptyFlag = true;
    }

    if (_editType == EditType.add) {
      if (emptyFlag) {
        return;
      }

      DateTime now = new DateTime.now();
      String time = now.toString();
      time = time.substring(0, time.lastIndexOf(":"));
      _timelineModel.time = time;

      _timeLineModelEditCallBack.addTimelineModel(_timelineModel);
    } else {
      if (emptyFlag) {
        _timeLineModelEditCallBack.deleteTimelineModel(_timelineModel);
      } else {
        _timeLineModelEditCallBack.updateTimelineModel(_timelineModel);
      }
    }
  }
}
