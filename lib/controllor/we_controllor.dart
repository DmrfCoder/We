import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_we/beans/event_bean.dart';
import 'package:flutter_we/beans/events_bean.dart';
import 'package:flutter_we/callback/listview_item_click_callback.dart';
import 'package:flutter_we/callback/timelinemodeledit_callback.dart';
import 'package:flutter_we/pages/addproject_page.dart';
import 'package:flutter_we/pages/we_page.dart';
import 'package:flutter_we/utils/file_util.dart';

class WeControllor
    implements ListviewItemClickCallBack, TimeLineModelEditCallBack {
  WeListPageState weListPageState;

  List<TimelineModel> timeLineModels = [];

  WeControllor(this.weListPageState);

  init() {
    FileIo fileIo = FileIo.getInstance();

    Future<String> jsoncontentfuture = fileIo.get();
    jsoncontentfuture.then((String jsoncontentfuture) {
      if (jsoncontentfuture.isEmpty) {
        return;
      } else {
        try {
          Map timelineModelMap = json.decode(jsoncontentfuture);
          var timelineModel = new TimeLineModelList.fromJson(timelineModelMap);
          timeLineModels = timelineModel.list;

          weListPageState.updateState(this);
        } catch (e) {
          print('error:' + e.toString() + " , content: " + jsoncontentfuture);
          return;
        }
      }
    });
  }

  dispose() {
    TimeLineModelList timeLineModelList = new TimeLineModelList(timeLineModels);

    String js = json.encode(timeLineModelList);
    FileIo fileIo = FileIo.getInstance();
    fileIo.save(js);
  }

  @override
  onLongPress(int index) {
    // TODO: implement onLongPress
    weListPageState.setState(() {
      showDialog(
          context: weListPageState.context,
          builder: (BuildContext ctx) {
            return new SimpleDialog(
              title: new Text("确认删除该条目？"),
              children: <Widget>[
                new SimpleDialogOption(
                  onPressed: () {
                    deleteIndex(index);
                    Navigator.pop(weListPageState.context);
                  },
                  child: const Text('确定'),
                ),
                new SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(weListPageState.context);
                  },
                  child: const Text('取消'),
                ),
              ],
            );
          });
    });
  }

  deleteIndex(int index) {
    timeLineModels.removeAt(index);
    for (int i = index; i < timeLineModels.length; i++) {
      timeLineModels[i].id = i;
    }

    weListPageState.updateState(this);
    dispose();
  }

  @override
  onTap(int index) {


    weListPageState.startAddProjectPage(timeLineModels[index]);

    // TODO: implement onTap
  }

  @override
  addTimelineModel(TimelineModel timelineModel) {
    // TODO: implement addTimelineModel
    if (timelineModel.id == -1) {
      //等于-1说明该model是添加的
      timelineModel.id = 0;
      for (TimelineModel itemModel in timeLineModels) {
        itemModel.id++;
      }

      timeLineModels.insert(0, timelineModel);
    } else {
      //否则说明该model是编辑之前的
      timeLineModels[timelineModel.id] = timelineModel;
    }

    weListPageState.updateState(this);

    dispose();
  }

  @override
  deleteTimelineModel(TimelineModel timelineModel) {
    // TODO: implement deleteTimelineModel

    timeLineModels.removeAt(timelineModel.id);
    weListPageState.updateState(this);

    dispose();
  }
}
