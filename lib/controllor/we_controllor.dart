import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/beans/edit_list_bean.dart';
import 'package:flutter_we/beans/event_bean.dart';
import 'package:flutter_we/beans/events_bean.dart';
import 'package:flutter_we/callback/listview_item_click_callback.dart';
import 'package:flutter_we/callback/timelinemodeledit_callback.dart';
import 'package:flutter_we/controllor/associate_callback.dart';
import 'package:flutter_we/pages/addproject_page.dart';
import 'package:flutter_we/pages/we_page.dart';
import 'package:flutter_we/utils/db_util.dart';
import 'package:flutter_we/utils/http_util.dart';
import 'package:flutter_we/utils/marry_util.dart';
import 'package:flutter_we/utils/share_preferences_util.dart';
//import 'package:flutter_we/utils/jpush_util.dart';

class WeControllor
    implements
        ListviewItemClickCallBack,
        TimeLineModelEditCallBack,
        AssociateCallBack {
  WeListPageState weListPageState;

  List<TimelineModel> timeLineModels = [];

  String userid;
  String otherId = "";
  bool isMarried = false;

  bool _sychWithServerFlag = false;

  setSychWithServerFlag(bool value) async {
    _sychWithServerFlag = value;
    for (TimelineModel model in timeLineModels) {
      if (!model.inServer) {
        var c = await HttpUtil.uploadData(timelineModel: model, userId: userid);
        if (!c['result']) {
          return false;
        }
      }
    }
    bool initFlag = await init();

    return initFlag;
  } //JpushUtil jpushUtil;

  getIdModel(String id) {
    for (TimelineModel item in timeLineModels) {
      if (item.id == id) {
        return item;
      }
    }

    return null;
  }

  initOther() async {
    var inquireValue = await MarryUtil.Inquire(userId: userid);
    isMarried = inquireValue['isMarried'];
    if(!isMarried){
      isMarried=false;
    }
    var otherValue =
        await MarryUtil.getUserIdByUserName(inquireValue['MarriedUser']);
    if ("false" != otherValue) {
      otherId = otherValue as String;
    }

    init();
  }

  initSp() async {
    SharePreferenceUtil sharePreferenceUtil =
        await SharePreferenceUtil.getInstance();
    bool temp_light = sharePreferenceUtil.getBool(SP_SYNCH_SWITCH_KEY);

    if (temp_light == null) {
      temp_light = false;
    }

    _sychWithServerFlag = temp_light;
    initOther();
  }

  WeControllor(this.weListPageState) {
    userid = weListPageState.widget.userid;
    initSp();
  }

  init() async {
    timeLineModels.clear();

    print("we contonller init");
    print(isMarried);

    if (isMarried) {
      if (otherId != "") {
        var otherValue = await HttpUtil.downloadData(otherId);

        if (otherValue["result"]) {
          List<TimelineModel> otherTimeLineModels =
              otherValue["timelineModelList"];

          for (TimelineModel model in otherTimeLineModels) {
            model.isOther = true;

            timeLineModels.add(model);
          }
        } else {}
      }
    }

    if (userid.isNotEmpty) {
      if (_sychWithServerFlag) {
        var value = await HttpUtil.downloadData(userid);

        if (value["result"]) {
          List<TimelineModel> mytimeLineModels = value["timelineModelList"];

          for (TimelineModel model in mytimeLineModels) {
            timeLineModels.add(model);
          }
        }

        timeLineModels.sort(_compare);

        weListPageState.updateState(this);
      } else {
        var result = await DbUtil.queryDataDb(userid);

        if (result["result"] >= 0) {
          List<TimelineModel> tempTimelineModels = result["timeLineModelList"];

          int len = tempTimelineModels.length;
          for (TimelineModel model in tempTimelineModels) {
            timeLineModels.add(model);
          }

          timeLineModels.sort(_compare);
          weListPageState.updateState(this);
        }
      }
    }
  }

  int _compare(TimelineModel a, TimelineModel b) {
    DateTime aTime = DateTime.parse(a.time);
    DateTime bTime = DateTime.parse(b.time);

    if (aTime.isAfter(bTime)) {
      return 0;
    } else {
      return 1;
    }
  }

  @override
  onLongPress(String id) {
    // TODO: implement onLongPress
    weListPageState.setState(() {
      showDialog(
          context: weListPageState.context,
          builder: (BuildContext ctx) {
            return new CupertinoAlertDialog(
              title: new Text("确认删除该条目？"),
              actions: <Widget>[
                new CupertinoDialogAction(
                  child: const Text('取消'),
                  onPressed: () {
                    Navigator.pop(weListPageState.context);
                  },
                ),
                new CupertinoDialogAction(
                  child: const Text('确定'),
                  onPressed: () {
                    deleteTimeLineModelById(id);
                    Navigator.pop(weListPageState.context);
                  },
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

    if (_sychWithServerFlag) {
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

    if (_sychWithServerFlag) {
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

  @override
  associateSuccess(String userName) async {
    // TODO: implement associateSuccess

    otherId = await MarryUtil.getUserIdByUserName(userName);
    if (otherId != "false") {
      isMarried = true;
      init();
    }
  }
}
