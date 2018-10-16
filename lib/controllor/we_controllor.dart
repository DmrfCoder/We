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
import 'package:flutter_we/utils/db_util.dart';
import 'package:flutter_we/utils/http_util.dart';

class WeControllor
    implements ListviewItemClickCallBack, TimeLineModelEditCallBack {
  WeListPageState weListPageState;

  List<TimelineModel> timeLineModels = [];

  String userid;

  bool hasDownLoadData = false;
  bool needNetWork = false;

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
    if (userid.isNotEmpty && needNetWork) {
      var value = await HttpUtil.downloadData(userid);

      if (value["result"]) {
        timeLineModels = value["timelineModelList"];
        hasDownLoadData = true;
        weListPageState.updateState(this);
      }
    }

    if (!hasDownLoadData) {
      var result = await DbUtil.queryDataDb(userid);
      print("query result:" + result.toString());

      if (result["result"] >= 0) {
        timeLineModels = result["timeLineModelList"];
      }

      /**
       * 从数据库中读取数据，将数据恢复到timeLineModels中
       */

    }
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
                    deleteTimeLineModelById(id);
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

  deleteTimeLineModelById(String id) async {
    TimelineModel timelineModel = new TimelineModel(id: id);
    deleteTimelineModel(timelineModel);


  }

  @override
  onTap(String id) {
    weListPageState.startAddProjectPage(getIdModel(id), EditType.edit);

    // TODO: implement onTap
  }

  @override
  addTimelineModel(TimelineModel timelineModel) async {
    // TODO: implement addTimelineModel

    /**
     *
     *将timelinemodel添加至数据库
     */

    timeLineModels.insert(0, timelineModel);

    weListPageState.updateState(this);
    int result = await DbUtil.insertDataToDb(userid, timelineModel);
    print("insert result:" + result.toString());
    if (result >= 0) {
      timelineModel.id = result.toString();
    }
    timeLineModels[0].id = result.toString();

    if (needNetWork) {
      var value = await HttpUtil.uploadData(
          timelineModel: timelineModel, userId: userid);

      if (value["result"]) {
        timelineModel.id = value["object_id"];
        print("upload data success");
      } else {
        print("upload data faild");
      }
    }
  }

  @override
  deleteTimelineModel(TimelineModel timelineModel) async {
    // TODO: implement deleteTimelineModel

    timeLineModels.removeWhere((model) => model.id == timelineModel.id);

    weListPageState.updateState(this);

    /**
     * 根据timelinemodel中的id删除本地数据库中的数据
     */

    int result = await DbUtil.deleteDataDb(userid, int.parse(timelineModel.id));
    print("delete result:" + result.toString());
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

    if (needNetWork) {
      var value = await HttpUtil.updateData(timelineModel);

      if (value["result"]) {
        print("update data success");
      } else {
        print("update data faild");
      }
    }

    /**
     * 根据timelinemodel中的内容更新本地db中的数据（更新content）
     */

    int result = await DbUtil.updateDataDb(
        userid, int.parse(timelineModel.id), timelineModel.editbeanList);
    print("update result:" + result.toString());
  }
}
