import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/callback/index_page_callback.dart';
import 'package:flutter_we/controllor/associate_callback.dart';
import 'package:flutter_we/pages/associate_page.dart';
import 'package:flutter_we/pages/login_page.dart';
import 'package:flutter_we/utils/marry_util.dart';
import 'package:flutter_we/utils/share_preferences_util.dart';
import 'package:flutter_we/widgets/progress_dialog_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserCenterPage extends StatefulWidget {
  String userid;
  String phoneNumber;
  IndexPageCallBack indexPageCallBack;

  UserCenterPage(this.userid, this.phoneNumber, this.indexPageCallBack);

  @override
  State<StatefulWidget> createState() => new UserCenterSate();
}

class UserCenterSate extends State<UserCenterPage>
    with AutomaticKeepAliveClientMixin
    implements AssociateCallBack {
  bool _lights = false;
  bool _loading = false;
  String progress_string = "";

  initSp() async {
    SharePreferenceUtil sharePreferenceUtil =
        await SharePreferenceUtil.getInstance();
    bool temp_light = sharePreferenceUtil.getBool(SP_SYNCH_SWITCH_KEY);

    if (temp_light == null) {
      temp_light = false;
    }

    setState(() {
      _lights = temp_light;
    });
  }

  saveSp() async {
    SharePreferenceUtil sharePreferenceUtil =
        await SharePreferenceUtil.getInstance();
    sharePreferenceUtil.putBool(SP_SYNCH_SWITCH_KEY, _lights);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSp();
    print("usercenter init--------");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    saveSp();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("用户中心"),
          backgroundColor: Color.fromRGBO(173, 195, 247, 1.0),
        ),
        body: _build_with_progress_dialog());
  }

  _build_with_progress_dialog() {
    return ProgressDialog(
        loading: _loading,
        msg: progress_string,
        child: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                image: new AssetImage("images/login_signup_background.jpg"),
                fit: BoxFit.cover,
              )),
            ),
            new Container(
              padding: EdgeInsets.all(8.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _userInfiLine(),
                  _associateLine(),
                  _messageLine(),
                  _fileExportLine(),
                  _syscDataLine(),
                  _logoutLine(),
                ],
              ),
            ),
          ],
        ));
  }

  _userInfiLine() {
    var firstLine = new Container(
      padding: EdgeInsets.all(4.0),
      height: 80.0,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new CircleAvatar(
            backgroundImage: new AssetImage("images/we_icon.png"),
          ),
          new Container(
            padding: EdgeInsets.only(left: 10.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  "用户名：" + widget.phoneNumber,
                  style: new TextStyle(color: Colors.black),
                ),
                new Text(
                  "用户id：" + widget.userid,
                  style: new TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
        ],
      ),
    );
    return new Card(
      child: firstLine,
    );
  }

  _associateLine() {
    var secondLine = new Container(
      padding: EdgeInsets.all(4.0),
      width: MediaQuery.of(context).size.width - 8.0,
      height: 60.0,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            child: new Text("账号关联"),
            padding: EdgeInsets.only(left: 8.0),
          )
        ],
      ),
    );

    var card = new GestureDetector(
      child: new Card(
        child: secondLine,
      ),
      onTap: () => _associate(),
    );
    return card;
  }

  _messageLine() {
    var secondLine = new Container(
      padding: EdgeInsets.all(4.0),
      width: MediaQuery.of(context).size.width - 8.0,
      height: 60.0,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            child: new Text("消息"),
            padding: EdgeInsets.only(left: 8.0),
          )
        ],
      ),
    );

    var card = new Card(
      child: secondLine,
    );
    return card;
  }

  _logoutLine() {
    var secondLine = new Container(
      padding: EdgeInsets.all(4.0),
      width: MediaQuery.of(context).size.width - 8.0,
      height: 60.0,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            child: new Text(
              "退出登陆",
              style: new TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );

    var card = new Card(
      child: secondLine,
      color: Colors.red,
    );

    return new GestureDetector(
      child: new Container(
        padding: EdgeInsets.only(top: 10.0),
        child: card,
      ),
      onTap: () => _logout(),
    );
  }

  _fileExportLine() {
    var secondLine = new Container(
      padding: EdgeInsets.all(4.0),
      width: MediaQuery.of(context).size.width - 8.0,
      height: 60.0,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            child: new Text("文件导出"),
            padding: EdgeInsets.only(left: 8.0),
          )
        ],
      ),
    );

    var card = new Card(
      child: secondLine,
    );
    return card;
  }

  _syscDataLine() {
    var secondLine = new Container(
      padding: EdgeInsets.all(4.0),
      width: MediaQuery.of(context).size.width - 8.0,
      height: 60.0,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new Container(
              child: new Text("数据同步"),
              padding: EdgeInsets.only(left: 8.0),
            ),
            flex: 2,
          ),
          new Expanded(
            child: new Text(""),
            flex: 5,
          ),
          new Expanded(
            child: ListTile(
              trailing: CupertinoSwitch(
                value: _lights,
                onChanged: (bool value) {
                  _showSwtchDialog(value);
                },
              ),
              onTap: () {
                setState(() {
                  _showSwtchDialog(!_lights);
                });
              },
            ),
            flex: 2,
          )
        ],
      ),
    );

    var card = new Card(
      child: secondLine,
    );
    return card;
  }

  _showSwtchDialog(bool switchValue) {
    String title = switchValue ? "确认开启数据同步？" : "确认关闭数据同步?";
    String content = switchValue
        ? "开启数据同步后您的本地数据将实时与服务器保持同步，这会消耗一定的流量，是否继续？"
        : "关闭数据同步后您的数据仅会存放在本地数据库，不能保证数据觉对安全，是否继续？";

    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return new CupertinoAlertDialog(
              title: new Text(title),
              content: new Text(content),
              actions: <Widget>[
                new CupertinoDialogAction(
                  child: const Text('取消'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                new CupertinoDialogAction(
                  child: const Text('继续'),
                  onPressed: () {
                    setState(() {
                      _lights = switchValue;
                    });
                    _updateSwichValue(switchValue);

                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    });
  }

  _updateSwichValue(bool switchValue) async {
    setState(() {
      if (switchValue) {
        progress_string = "正在同步数据...";
      } else {
        progress_string = "正在关闭数据同步...";
      }
      _loading = true;
    });
    bool updateFlag = await widget.indexPageCallBack
        .swichSychDataUserCenterCallBack(switchValue);
    setState(() {
      _loading = false;
    });
  }

  _associate() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new AssociatePage(widget.userid, this);
    }));
  }

  _logout() {
    Fluttertoast.showToast(
      msg: "退出登陆",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
    );
    Navigator.pushAndRemoveUntil(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new LoginPage(
        false,
      );
    }), (route) => route == null);
  }

  @override
  associateSuccess(String userName) async {
    // TODO: implement associateSuccess
    String otherId = await MarryUtil.getUserIdByUserName(userName);
    if (otherId != "false") {
      widget.indexPageCallBack.associteFromUserCenterCallBack(otherId);
    }
    return null;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
