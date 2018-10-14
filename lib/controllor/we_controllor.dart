import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_we/beans/data_responseinfo_bean.dart';
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

    if (userid.isNotEmpty) {
      DataResponseInfoBean dataResponseInfoBean =
          await HttpUtil.downloadData(userid);

      if (dataResponseInfoBean.result) {
        Map map = dataResponseInfoBean.datdaContent;

        map.forEach((key, value) {
          Map timelineModelMap = json.decode(value["content"]);

          EditbeanList editbeanList =
              new EditbeanList.fromJson(timelineModelMap);

          TimelineModel timelineModel = new TimelineModel(
              time: value["createdTime"], editbeanList: editbeanList, id: key);

          timeLineModels.add(timelineModel);
        });

        hasDownLoadData = true;
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

  deleteItem(String id) {
    timeLineModels.removeWhere((timelinemodel) {
      timelinemodel.id == id;
    });
    weListPageState.updateState(this);
    dispose();
  }

  @override
  onTap(String id) {
    weListPageState.startAddProjectPage(getIdModel(id));

    // TODO: implement onTap
  }

  @override
  addTimelineModel(TimelineModel timelineModel) async {
    // TODO: implement addTimelineModel

    timeLineModels.insert(0, timelineModel);

    weListPageState.updateState(this);

    DataResponseInfoBean dataResponseInfoBean =
        await HttpUtil.uploadData(timelineModel: timelineModel, userId: userid);

    if (dataResponseInfoBean.result) {
      timelineModel.id = dataResponseInfoBean.objectId;
    } else {
      timelineModel.id = timeLineModels.length.toString();
    }

    dispose();
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

    DataResponseInfoBean dataResponseInfoBean= await HttpUtil.updateData(timelineModel);
    if(dataResponseInfoBean.result){
      print("update data success");
    }else{
      print("update data faild");
    }

    dispose();
  }
}
