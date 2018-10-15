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
  EditbeanList _editbeanList;

  TimelineModel _timelineModel;

  TimeLineModelEditCallBack _timeLineModelEditCallBack;

  var children;

  EditType _editType;

  EditType get editType => _editType;

  EditorControllor(this._timeLineModelEditCallBack) {
    _editbeanList = new EditbeanList();
    _curIndex = 0;
    children = <Widget>[];

    _editbeanList.addEditBean("", _curIndex, true);

    _editType = EditType.add;
  }

  set editType(EditType value) {
    _editType = value;
  }

  set timelineModel(TimelineModel value) {
    _timelineModel = value;
    _editbeanList = _timelineModel.editbeanList;
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
    if (index < 0 || index >= _editbeanList.list.length) {
      return false;
    } else {
      _editbeanList.list[index] = editbean;
      return true;
    }
  }

  addPicture(String strImage) {
    _curIndex = _editbeanList.addEditBean(strImage, _curIndex, false);
  }

  dispose() {
    List<EditBean> removeItems = [];

    for (EditBean editbeanItem in editbeanList.list) {
      if (editbeanItem.isText) {
        if (editbeanItem.content.isEmpty) {
          print('remove');
          removeItems.add(editbeanItem);
        }
      }
    }

    for (EditBean editbeanItem in removeItems) {
      editbeanList.list.remove(editbeanItem);
    }

    bool emptyFlag = false;

    if (editbeanList.list.length == 0) {
      emptyFlag = true;
    }

    if (_editType == EditType.add) {
      if (emptyFlag) {
        return;
      }

      DateTime now = new DateTime.now();
      String time = now.toString();
      time = time.substring(0, time.lastIndexOf(":"));

      TimelineModel timelineModel = new TimelineModel(
        time: time,
        editbeanList: editbeanList,
      );
      String js = json.encode(timelineModel);

      _timeLineModelEditCallBack.addTimelineModel(timelineModel);
    } else {
      _timelineModel.editbeanList = editbeanList;
      if (emptyFlag) {
        _timeLineModelEditCallBack.deleteTimelineModel(_timelineModel);
      } else {
        _timeLineModelEditCallBack.updateTimelineModel(_timelineModel);
      }
    }
  }
}
