import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_we/controllor/associate_callback.dart';
import 'package:flutter_we/utils/marry_util.dart';

class AssociatePage extends StatefulWidget {
  String userId;
  AssociateCallBack associateCallBack;

  AssociatePage(this.userId, this.associateCallBack);

  @override
  State<StatefulWidget> createState() => new _AssociateState();
}

class _AssociateState extends State<AssociatePage> {
  final TextEditingController _associateController =
      new TextEditingController();

  bool isMarried = false;
  String marriedUser = "";
  String WaitMarryUser = "";

  _inquireCurUserStatus() async {
    var inquireStatus = await MarryUtil.Inquire(userId: widget.userId);

    setState(() {
      marriedUser = inquireStatus["MarriedUser"];
      isMarried = inquireStatus['isMarried'];
      WaitMarryUser = inquireStatus['WaitMarryUser'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _inquireCurUserStatus();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new Stack(children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
              image: new AssetImage("images/login_signup_background.jpg"),
              fit: BoxFit.cover,
            )),
          ),
          new GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, //垂直方向对其方式
            crossAxisAlignment: CrossAxisAlignment.start, //水平方向对其方式

            children: <Widget>[
              new Center(
                child: new Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                            padding: const EdgeInsets.only(top: 32.0),
                            child: !isMarried
                                ? new TextField(
                                    controller: _associateController,
                                    keyboardType: TextInputType.phone,
                                    cursorColor: Colors.black,
                                    decoration: new InputDecoration(
                                      hintText: '要关联的手机号码',
                                      icon: new Icon(Icons.phone,
                                          color: Colors.white),
                                    ),
                                  )
                                : new Center(
                                    child: new Row(
                                      children: <Widget>[
                                        new Text(
                                          "已关联账号： " + marriedUser,
                                          style: new TextStyle(
                                            //background: paint,
                                            color: Colors.black,
                                            fontSize: 20.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  )),
                      ]),
                ),
              ),
              new Center(
                child: new Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: new Material(
                    child: new FlatButton(
                      child: new Container(
                        child: new Center(
                            child: !isMarried
                                ? new GestureDetector(
                                    child: new Text(
                                      "关 联",
                                      textScaleFactor: 1.5,
                                      style: new TextStyle(
                                          color: Colors.purple[100],
                                          fontFamily: "Roboto"),
                                    ),
                                    onTap: () {
                                      _associate(
                                          _associateController.text, context);
                                    },
                                  )
                                : new GestureDetector(
                                    child: new Text(
                                      "解 除 关 联",
                                      textScaleFactor: 1.5,
                                      style: new TextStyle(
                                          color: Colors.purple[100],
                                          fontFamily: "Roboto"),
                                    ),
                                    onTap: () {
                                      _cancelAssociate(context);
                                    },
                                  )),
                      ),
                      onPressed: () {
                        _handleSubmitted();
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

  void _handleSubmitted() {}

  void _cancelAssociate(BuildContext buildcontext) {
    MarryUtil.cancel_Associate(userid: widget.userId);
    setState(() {
      showDialog(
          context: buildcontext,
          builder: (BuildContext ctx) {
            return new CupertinoAlertDialog(
              title: new Text("取消关联成功"),
              content: new Text("已成功取消关联目标账户"),
              actions: <Widget>[
                new CupertinoDialogAction(
                  child: const Text('确定'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(buildcontext);
                  },
                )
              ],
            );
          });
    });
  }

  void _associate(String otherUserPhone, BuildContext buildcontext) {
    MarryUtil.associate_User(
        myUserId: widget.userId, otherUserPhone: otherUserPhone);

    widget.associateCallBack.associateSuccess(otherUserPhone);

    setState(() {
      showDialog(
          context: buildcontext,
          builder: (BuildContext ctx) {
            return new CupertinoAlertDialog(
              title: new Text("关联成功"),
              content: new Text("已成功关联目标账户"),
              actions: <Widget>[
                new CupertinoDialogAction(
                  child: const Text('确定'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(buildcontext);
                  },
                )
              ],
            );
          });
    });
  }
}
