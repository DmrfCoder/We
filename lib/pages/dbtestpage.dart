import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_we/pages/signup_page.dart';
import 'package:flutter_we/pages/we_page.dart';
import 'package:flutter_we/utils/db_util.dart';
import 'package:flutter_we/utils/http_util.dart';
import 'package:flutter_we/utils/share_preferences_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DbPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _DbPageState();
}

class _DbPageState extends State<DbPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        body: new Stack(children: <Widget>[
      new Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
          image: new AssetImage("images/login_signup_background.jpg"),
          fit: BoxFit.cover,
        )),
      ),
      new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, //垂直方向对其方式
        crossAxisAlignment: CrossAxisAlignment.start, //水平方向对其方式

        children: <Widget>[
          new Center(
            child: new Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: new Material(
                child: new FlatButton(
                  child: new Container(
                    child: new Center(
                        child: new Text(
                      "insert",
                      textScaleFactor: 1.5,
                      style: new TextStyle(
                          color: Colors.purple[100], fontFamily: "Roboto"),
                    )),
                  ),
                  onPressed: () {
                    _insert();
                  },
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                shadowColor: Colors.grey[200],
                elevation: 5.0,
              ),
            ),
          ),
          new Center(
            child: new Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: new Material(
                child: new FlatButton(
                  child: new Container(
                    child: new Center(
                        child: new Text(
                      "query",
                      textScaleFactor: 1.5,
                      style: new TextStyle(
                          color: Colors.purple[100], fontFamily: "Roboto"),
                    )),
                  ),
                  onPressed: () {
                    _query();
                  },
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                shadowColor: Colors.grey[200],
                elevation: 5.0,
              ),
            ),
          ),
          new Center(
            child: new Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: new Material(
                child: new FlatButton(
                  child: new Container(
                    child: new Center(
                        child: new Text(
                      "delete",
                      textScaleFactor: 1.5,
                      style: new TextStyle(
                          color: Colors.purple[100], fontFamily: "Roboto"),
                    )),
                  ),
                  onPressed: () {
                    _delete();
                  },
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                shadowColor: Colors.grey[200],
                elevation: 5.0,
              ),
            ),
          ),
          new Center(
            child: new Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: new Material(
                child: new FlatButton(
                  child: new Container(
                    child: new Center(
                        child: new Text(
                      "update",
                      textScaleFactor: 1.5,
                      style: new TextStyle(
                          color: Colors.purple[100], fontFamily: "Roboto"),
                    )),
                  ),
                  onPressed: () {
                    _update();
                  },
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                shadowColor: Colors.grey[200],
                elevation: 5.0,
              ),
            ),
          ),
        ],
      ),
    ]));
  }

  _insert() async {
    int result = await DbUtil.insertDataToDb("test", null);
    print("insert result:" + result.toString());
  }

  _query() async {
    int result = await DbUtil.queryDataDb(null);
    print("query result:" + result.toString());
  }

  _delete() async {
  //  int result = await DbUtil.deleteDataDb(1, null);
   // print("delete result:" + result.toString());
  }

  _update() async {
//    int result = await DbUtil.updateDataDb(3, null, null);
//    print("update result:" + result.toString());
  }
}
