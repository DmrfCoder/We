import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_we/beans/event_bean.dart';
import 'package:flutter_we/beans/events_bean.dart';
import 'package:flutter_we/controllor/we_controllor.dart';
import 'package:flutter_we/pages/addproject_page.dart';
import 'package:flutter_we/utils/file_util.dart';
import 'package:flutter_we/widgets/timeline_widget.dart';

class WeListPage extends StatefulWidget {
  @override
  WeListPageState createState() => new WeListPageState();
}

class WeListPageState extends State<WeListPage> {
  WeControllor weControllor;

  //可以在该方法中初始化数据
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    weControllor = new WeControllor(this);
    weControllor.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    weControllor.dispose();

    super.dispose();
  }

  updateState(WeControllor state) {
    setState(() {
      weControllor = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('we'),
      ),
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('images/mainbackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: new TimelineComponent(
          timelineList: weControllor.timeLineModels,
          listviewItemClickCallBack: weControllor,
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => startAddProjectPage(null),
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }

  startAddProjectPage(TimelineModel timelineModel) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new AddProjectPage(timelineModel, weControllor);
    }));
  }
}
