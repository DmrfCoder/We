import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_we/animation/floatingbutton_animation.dart';
import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/beans/event_bean.dart';
import 'package:flutter_we/beans/events_bean.dart';
import 'package:flutter_we/callback/floatingbutton_iconclickcallback_callback.dart';
import 'package:flutter_we/controllor/we_controllor.dart';
import 'package:flutter_we/pages/addproject_page.dart';
import 'package:flutter_we/pages/associate_page.dart';
import 'package:flutter_we/pages/login_page.dart';
import 'package:flutter_we/pages/message_page.dart';
import 'package:flutter_we/pages/todo_work_page.dart';
import 'package:flutter_we/utils/http_util.dart';
import 'package:flutter_we/utils/marry_util.dart';
import 'package:flutter_we/widgets/timeline_widget.dart';

class WeListPage extends StatefulWidget {
  String userid;
  String phoneNumber;
  String sessionToken;

  WeListPage(this.userid, this.phoneNumber, this.sessionToken);

  @override
  WeListPageState createState() => new WeListPageState();
}

class WeListPageState extends State<WeListPage>
    implements FloatButtonIconClickCallBack {
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

    super.dispose();
  }

  updateState(WeControllor state) {
    setState(() {
      weControllor = state;
    });
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _logCounter() {
    setState(() {
      print(_counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      drawer: new Drawer(
        child: new Stack(
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
                new UserAccountsDrawerHeader(
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: new NetworkImage(
                              "http://t2.hddhhn.com/uploads/tu/201612/98/st93.png"))),
                  accountName: new Text("phone:" + widget.phoneNumber),
                  accountEmail: new Text("userid:" + widget.userid),
                ),
                new Row(
                  children: <Widget>[
                    new GestureDetector(
                      onTap: () => _associate(),
                      child: new Container(
                        padding: EdgeInsets.only(
                            left: 10.0, top: 10.0, bottom: 10.0),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: new Text("账号关联"),
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new GestureDetector(
                      onTap: () => _message(),
                      child: new Container(
                        padding: EdgeInsets.only(
                            left: 10.0, top: 10.0, bottom: 10.0),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: new Text("消息"),
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new GestureDetector(
                      onTap: () => _todoWork(),
                      child: new Container(
                        padding: EdgeInsets.only(
                            left: 10.0, top: 10.0, bottom: 10.0),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: new Text("备忘录"),
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new GestureDetector(
                      onTap: () => _logout(),
                      child: new Container(
                        padding: EdgeInsets.only(
                            left: 10.0, top: 10.0, bottom: 10.0),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: new Text("退出登陆"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: new RefreshIndicator(
        child: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                image: new AssetImage("images/login_signup_background.jpg"),
                fit: BoxFit.cover,
              )),
            ),

            new TimelineComponent(
              timelineList: weControllor.timeLineModels,
              listviewItemClickCallBack: weControllor,
              lineColor: Colors.black,
            ),

            // _buildTimeline(),
          ],
        ),
        onRefresh: _refresh,
      ),
      floatingActionButton: new AnimatedFab(
        floatButtonIconClickCallBack: this,
      ),
    );
  }

  startAddProjectPage(TimelineModel timelineModel, EditType editType) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new AddProjectPage(timelineModel, weControllor, editType);
    }));
  }

  @override
  void floatIconOnClick(MessageType messageType) {
    // TODO: implement floatIconOnClick
    startAddProjectPage(
        new TimelineModel(messageType: messageType), EditType.add);
  }

  _logout() {
    Navigator.pushAndRemoveUntil(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new LoginPage(
        false,
      );
    }), (route) => route == null);
  }

  _associate() {
//    MarryUtil.addWaitMarrayUser(
//        myUserId: "00550567ea",
//        otherUserId: "d03745ca20",
//        sessionToken: widget.sessionToken);

    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new AssociatePage(widget.userid, weControllor);
    }));
  }

  _message() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new MessagePage();
    }));
  }

  Future<Null> _refresh() async {
    weControllor.initOther();
    weControllor.init();
    print("refresh");
    return;
  }

  _todoWork() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new ToDoWorkPage(widget.userid);
    }));
  }
}
