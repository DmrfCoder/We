import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_we/beans/event_bean.dart';
import 'package:flutter_we/beans/events_bean.dart';
import 'package:flutter_we/pages/addproject_page.dart';
import 'package:flutter_we/utils/file_util.dart';
import 'package:flutter_we/widgets/timeline_widget.dart';

class WeListPage extends StatefulWidget {
  @override
  WeListPageState createState() => new WeListPageState();
}

class WeListPageState extends State<WeListPage> {
  List<TimelineModel> list = [];

  //可以在该方法中初始化数据
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    eventBus
        .on<TimelineModel>()
        .listen((TimelineModel model) => onAddEvent(model));

    Future<String> jsoncontentfuture = FileIo.get();
    String a = "";
    jsoncontentfuture.then((String jsoncontentfuture) {
      a = jsoncontentfuture;
      print(a);
      Map timelineModelMap = json.decode(a);
      var timelineModel = new TimeLineModelList.fromJson(timelineModelMap);
      list = timelineModel.list;
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    String js = json.encode(list);
    print("dispose:" + js);
    FileIo.save(js);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('wjy同學'),
      ),
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('images/mainbackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: new TimelineComponent(
          timelineList: list,
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: navigateToMovieDetailPage,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }

  navigateToMovieDetailPage() {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new AddProjectPage();
    }));
  }

  onAddEvent(TimelineModel model) {
    list.add(model);

    TimeLineModelList timeLineModelList = new TimeLineModelList(list);

    String js = json.encode(timeLineModelList);
    FileIo.save(js);
  }
}
