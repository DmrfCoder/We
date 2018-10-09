import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_we/beans/event_bean.dart';
import 'package:flutter_we/beans/events_bean.dart';
import 'package:flutter_we/callback/listview_item_click_callback.dart';
import 'package:flutter_we/pages/addproject_page.dart';
import 'package:flutter_we/pages/we_page.dart';
import 'package:flutter_we/utils/file_util.dart';

class WeControllor implements ListviewItemClickCallBack {
  WeListPageState weListPageState;

  List<TimelineModel> list = [];

  WeControllor(this.weListPageState);

  init() {
    eventBus
        .on<TimelineModel>()
        .listen((TimelineModel model) => _onAddEvent(model));

    FileIo fileIo = FileIo.getInstance();

    Future<String> jsoncontentfuture = fileIo.get();
    jsoncontentfuture.then((String jsoncontentfuture) {
      if (jsoncontentfuture.isEmpty) {
        return;
      } else {
        try {
          Map timelineModelMap = json.decode(jsoncontentfuture);
          var timelineModel = new TimeLineModelList.fromJson(timelineModelMap);
          list = timelineModel.list;

          weListPageState.updateState(this);
        } catch (e) {
          print('error:' + e.toString() + " , content: " + jsoncontentfuture);
          return;
        }
      }
    });
  }

  _onAddEvent(TimelineModel model) {

    if(model.id==-1){
      //等于-1说明该model是添加的
      model.id = list.length;
      list.add(model);
    }else{
      //否则说明该model是编辑之前的
      list[model.id]=model;

    }


    weListPageState.updateState(this);

    dispose();
  }

  dispose() {
    TimeLineModelList timeLineModelList = new TimeLineModelList(list);

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
    list.removeAt(index);
    for (int i = index; i < list.length; i++) {
      list[i].id = i;
    }

    weListPageState.updateState(this);
    dispose();
  }

  @override
  onTap(int index) {
    print("ontap:" + index.toString());

    weListPageState.startAddProjectPage(list[index]);

    // TODO: implement onTap
  }
}
