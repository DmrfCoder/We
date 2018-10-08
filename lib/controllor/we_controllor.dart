import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_we/beans/event_bean.dart';
import 'package:flutter_we/beans/events_bean.dart';
import 'package:flutter_we/callback/listview_item_click_callback.dart';
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
        Map timelineModelMap = json.decode(jsoncontentfuture);
        var timelineModel = new TimeLineModelList.fromJson(timelineModelMap);
        list = timelineModel.list;
        weListPageState.setState(() {});
      }
    });
  }

  _onAddEvent(TimelineModel model) {
    model.id = list.length;

    weListPageState.setState(() {
      list.add(model);
    });

    TimeLineModelList timeLineModelList = new TimeLineModelList(list);

    String js = json.encode(timeLineModelList);
    FileIo fileIo = FileIo.getInstance();
    fileIo.save(js);
  }

  dispose(){
    String js = json.encode(list);
    print("dispose:" + js);
    FileIo fileIo = FileIo.getInstance();
    fileIo.save(js);
  }

  @override
  onLongPress(int index) {
    // TODO: implement onLongPress
    showDialog(
        context: weListPageState.context,
        builder: (BuildContext ctx) {
          return new SimpleDialog(
            title: new Text("确认删除该条目？"),
            children: <Widget>[
              new SimpleDialogOption(
                onPressed: () {

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

  }

  @override
  onTap(int index) {
    // TODO: implement onTap
  }


}
