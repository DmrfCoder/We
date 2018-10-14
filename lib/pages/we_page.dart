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
  String userid;

  WeListPage(this.userid);

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
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: new NetworkImage(
                            "http://t2.hddhhn.com/uploads/tu/201612/98/st93.png")
                    )),
                accountName: new Text("demo"),
                accountEmail: new Text("demo@gmail.com"),
            ),
            new Row(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: new Text("自动备份数据"),
                ),
                new Switch(
                    value: true,
                    onChanged: (value) {
                      print(value.toString());
                    }),
              ],
            ),
            new Row(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: new Text("退出登陆"),
                ),
              ],
            ),
          ],
        ),
      ),
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
              image: new AssetImage("images/login_signup_background.jpg"),
              fit: BoxFit.cover,
            )),
          ),
          new Column(
            children: <Widget>[
              new Center(
                child: new Container(
                  padding: const EdgeInsets.only(top: 32.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: new TimelineComponent(
                    timelineList: weControllor.timeLineModels,
                    listviewItemClickCallBack: weControllor,
                    lineColor: Colors.black,
                  ),
                ),
              ),
              new Center(
                  child: new Container(
                child: new FloatingActionButton(
                  onPressed: () => startAddProjectPage(null),
                  tooltip: 'Increment',
                  child: new Icon(Icons.add),
                  backgroundColor: Colors.black,
                ),
              ))
            ],
          ),
        ],
      ),
    );
  }

  startAddProjectPage(TimelineModel timelineModel) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new AddProjectPage(timelineModel, weControllor);
    }));
  }

//    new TimelineComponent(
//      timelineList: weControllor.timeLineModels,
//      listviewItemClickCallBack: weControllor,
//    ),

}
