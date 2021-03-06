import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/pages/IndexPage.dart';
import 'package:flutter_we/pages/signup_page.dart';
import 'package:flutter_we/pages/we_page.dart';
import 'package:flutter_we/utils/http_util.dart';
import 'package:flutter_we/utils/share_preferences_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  bool autoLogin = true;

  LoginPage(this.autoLogin);

  @override
  State<StatefulWidget> createState() => new _LoginState();
}

class _LoginState extends State<LoginPage> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();

  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  bool _correctPhone = true;
  bool _correctPassword = true;

  bool showProgress = false;

  String _userid = "";

  void _checkInput() {
    if (_phoneController.text.isNotEmpty &&
        (_phoneController.text.trim().length < 7 ||
            _phoneController.text.trim().length > 12)) {
      _correctPhone = false;
    } else {
      _correctPhone = true;
    }
    if (_passwordController.text.isNotEmpty &&
        _passwordController.text.trim().length < 6) {
      _correctPassword = false;
    } else {
      _correctPassword = true;
    }
    setState(() {});
  }

  _login() async {
    showProgress = true;
    var value = await HttpUtil.login(
        phonenumber: _phoneController.text, password: _passwordController.text);

    if (!value["result"]) {
      setState(() {
        showProgress = false;
      });

      Fluttertoast.showToast(
        msg: value["error"] == null ? "登陆失败，请检查您的网络!" : value["error"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
      );

      return;
    } else {
      setState(() {
        showProgress = false;
      });

      Fluttertoast.showToast(
        msg: "登陆成功！",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
      );

      navigateToIndexPage(value["user_id"], value["sessionToken"]);
    }
  }

  Future _handleSubmitted() async {
    bool check = true;

    FocusScope.of(context).requestFocus(new FocusNode());
    _checkInput();
    if (_phoneController.text == '' || _passwordController.text == '') {
      check = false;
      return;
    } else if (!_correctPhone || !_correctPassword) {
      check = false;
      return;
    }

    _login();
  }

  _buildProgress() {
    if (showProgress) {
      return new Center(
          child: new CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.pink),
      ));
    } else {
      return Center();
    }
  }

  _getSpInfo() async {
    SharePreferenceUtil sharePreferenceUtil =
        await SharePreferenceUtil.getInstance();
    _phoneController.text = sharePreferenceUtil.getString(SP_PHONE_KEY);
    _passwordController.text = sharePreferenceUtil.getString(SP_PASSWORD_kEY);

    if (!widget.autoLogin) {
      return;
    }
    if (_passwordController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      _login();
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _getSpInfo();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        key: _scaffoldKey,
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
                          child: new TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            cursorColor: Colors.black,
                            decoration: new InputDecoration(
                              hintText: '手机号码',
                              errorText:
                                  _correctPhone ? null : '号码的长度应该在7到12位之间',
                              icon: new Icon(Icons.phone, color: Colors.white),
                            ),
                            onSubmitted: (value) {
                              _checkInput();
                            },
                          ),
                        ),
                        new Container(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: new TextField(
                            controller: _passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            decoration: new InputDecoration(
                              hintText: '密码',
                              errorText: _correctPassword ? null : '密码的长度需大于6位',
                              icon: new Icon(Icons.lock_outline,
                                  color: Colors.white),
                            ),
                            onSubmitted: (value) {
                              _checkInput();
                            },
                          ),
                        )
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
                            child: new Text(
                          "登 录",
                          textScaleFactor: 1.5,
                          style: new TextStyle(
                              color: Colors.purple[100], fontFamily: "Roboto"),
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
              new Center(
                child: new FlatButton(
                    child: new Text("没有帐户？ 注册",
                        style: new TextStyle(color: Colors.black38)),
                    onPressed: _openSignUp),
              ),
            ],
          ),
          _buildProgress(),
        ]));
  }

  putSpInfo() async {
    SharePreferenceUtil sharePreferenceUtil =
        await SharePreferenceUtil.getInstance();

    sharePreferenceUtil.putString(SP_PHONE_KEY, _phoneController.text);
    sharePreferenceUtil.putString(SP_PASSWORD_kEY, _passwordController.text);
  }

  navigateToIndexPage(String userid, String sessionToken) {
    putSpInfo();
    Navigator.pushAndRemoveUntil(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new IndexPage(userid, _phoneController.text, sessionToken);
    }), (route) => route == null);
  }

  void _openSignUp() {
    setState(() {
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) {
          return new SignUpPage();
        },
      )).then((onValue) {
        if (onValue != null) {
          _phoneController.text = onValue[0];
          _passwordController.text = onValue[1];
          _userid = onValue[2];
        }
      });
    });
  }
}
