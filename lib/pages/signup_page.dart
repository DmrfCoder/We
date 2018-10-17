import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_we/utils/http_util.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final TextEditingController _password2Controller =
      new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();

  bool _correctPhone = true;

  bool showProgress = false;

  Future _handleSubmitted() async {
    _checkInput();

    if (_password2Controller.text == '' ||
        _passwordController.text == '' ||
        _passwordController.text == '') {
//      Fluttertoast.showToast(
//          msg: "注册信息填写不完整！",
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.BOTTOM,
//          timeInSecForIos: 1,
//          bgcolor: "#e74c3c",
//          textcolor: '#ffffff');

      return;
    } else if (_passwordController.text != _password2Controller.text) {
//      Fluttertoast.showToast(
//          msg: "两次密码不一致！",
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.BOTTOM,
//          timeInSecForIos: 1,
//          bgcolor: "#e74c3c",
//          textcolor: '#ffffff');
      return;
    }

    showProgress = true;
    var value = await HttpUtil.signup(
      phonenumber: _phoneController.text,
      password: _passwordController.text,
    );

    if (value["result"]) {
      setState(() {
        showProgress = false;
      });

//      Fluttertoast.showToast(
//          msg: "注册成功！",
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.BOTTOM,
//          timeInSecForIos: 1,
//          bgcolor: "#e74c3c",
//          textcolor: '#ffffff');

      List<String> onBackInfo = [
        _phoneController.text,
        _passwordController.text,
        value["user_id"]
      ];

      Navigator.of(context).pop(onBackInfo);
    } else {
      setState(() {
        showProgress = false;
      });

//      Fluttertoast.showToast(
//          msg: value["error"] == null ? "注册失败，请检查您的网络！" : value["error"],
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.BOTTOM,
//          timeInSecForIos: 1,
//          bgcolor: "#e74c3c",
//          textcolor: '#ffffff');
      return;
    }
  }

  void _checkInput() {
    if (_phoneController.text.isNotEmpty &&
        (_phoneController.text.trim().length != 11)) {
      _correctPhone = false;
    } else {
      _correctPhone = true;
    }

    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(children: <Widget>[
      new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            _checkInput();
          },
          child: new Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
              image: new AssetImage("images/login_signup_background.jpg"),
              fit: BoxFit.cover,
            )),
          )),
      new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
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
                            errorText: _correctPhone ? null : '号码的长度应该在7到12位之间',
                            icon: new Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                          ),
                          onSubmitted: (value) {
                            _checkInput();
                          },
                        ),
                      ),
                      new Container(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: new TextField(
                          obscureText: true,
                          controller: _password2Controller,
                          cursorColor: Colors.black,
                          decoration: new InputDecoration(
                            hintText: '密码',
                            icon: new Icon(
                              Icons.lock_outline,
                              color: Colors.white,
                            ),
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
                            hintText: '确认密码',
                            icon: new Icon(
                              Icons.lock_outline,
                              color: Colors.white,
                            ),
                          ),
                          onSubmitted: (value) {
                            _checkInput();
                          },
                        ),
                      )
                    ])),
            new Center(
              child: new Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: new Material(
                  child: new FlatButton(
                    child: new Container(
                      child: new Center(
                          child: new Text(
                        "注 册",
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
              child: new Text("已经有账户了？ 登录",
                  style: new TextStyle(color: Colors.black38)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ))
          ]),
      _buildProgress(),
    ]));
  }
}
