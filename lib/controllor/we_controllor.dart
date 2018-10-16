import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/beans/edit_list_bean.dart';
import 'package:flutter_we/beans/event_bean.dart';
import 'package:flutter_we/beans/events_bean.dart';
import 'package:flutter_we/callback/listview_item_click_callback.dart';
import 'package:flutter_we/callback/timelinemodeledit_callback.dart';
import 'package:flutter_we/pages/addproject_page.dart';
import 'package:flutter_we/pages/we_page.dart';
import 'package:flutter_we/utils/file_util.dart';
import 'package:flutter_we/utils/http_util.dart';

class WeControllor
    implements ListviewItemClickCallBack, TimeLineModelEditCallBack {
  WeListPageState weListPageState;

  List<TimelineModel> timeLineModels = [];

  String userid;

  getIdModel(String id) {
    for (TimelineModel item in timeLineModels) {
      if (item.id == id) {
        return item;
      }
    }

    return null;
  }

  WeControllor(this.weListPageState) {
    userid = weListPageState.widget.userid;
  }

  init() async {
    bool hasDownLoadData = false;
    bool needdownLoadData = false;

    if (userid.isNotEmpty && needdownLoadData) {
      var value = await HttpUtil.downloadData(userid);

      if (value["result"]) {
        timeLineModels = value["timelineModelList"];
        hasDownLoadData = true;
        weListPageState.updateState(this);
      }
    }

    if (!hasDownLoadData) {
      FileIo fileIo = FileIo.getInstance();

      Future<String> jsoncontentfuture = fileIo.get();
      jsoncontentfuture.then((String jsoncontentfuture) {
        if (jsoncontentfuture.isEmpty) {
          return;
        } else {
          try {
            Map timelineModelMap = json.decode(jsoncontentfuture);
            var timelineModel =
                new TimeLineModelList.fromJson(timelineModelMap);
            timeLineModels = timelineModel.list;

            print("get data from io:" + timelineModel.list.length.toString());

            weListPageState.updateState(this);
          } catch (e) {
            print('error:' + e.toString() + " , content: " + jsoncontentfuture);
            return;
          }
        }
      });
    }
  }

  dispose() {
    TimeLineModelList timeLineModelList = new TimeLineModelList(timeLineModels);

    String js = json.encode(timeLineModelList);
    FileIo fileIo = FileIo.getInstance();
    fileIo.save(js);
  }

  @override
  onLongPress(String id) {
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
                    deleteItem(id);
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

  deleteItem(String id) async {
    timeLineModels.removeWhere((timelinemodel) {
      timelinemodel.id == id;
    });
    weListPageState.updateState(this);
    dispose();
    var value = await HttpUtil.deleteData(id);

    if (value["result"]) {
      print("删除云端数据成功");
    } else {
      print("删除云端数据失败");
    }
  }

  @override
  onTap(String id) {
    weListPageState.startAddProjectPage(getIdModel(id), EditType.edit);

    // TODO: implement onTap
  }

  @override
  addTimelineModel(TimelineModel timelineModel) async {
    // TODO: implement addTimelineModel

    timeLineModels.insert(0, timelineModel);

    weListPageState.updateState(this);

    dispose();

    var value =
        await HttpUtil.uploadData(timelineModel: timelineModel, userId: userid);

    if (value["result"]) {
      timelineModel.id = value["object_id"];
      print("upload data success");
    } else {
      print("upload data faild");
    }
  }

  @override
  deleteTimelineModel(TimelineModel timelineModel) {
    // TODO: implement deleteTimelineModel

    timeLineModels.removeWhere((model) => model.id == timelineModel.id);

    weListPageState.updateState(this);

    dispose();
  }

  @override
  updateTimelineModel(TimelineModel timelineModel) async {
    // TODO: implement updateTimelineModel

    for (TimelineModel model in timeLineModels) {
      if (model.id == timelineModel.id) {
        model = timelineModel;
      }
    }

    weListPageState.updateState(this);

    var value = await HttpUtil.updateData(timelineModel);

    if (value["result"]) {
      print("update data success");
    } else {
      print("update data faild");
    }

    dispose();
  }
}
