import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_we/pages/signup_page.dart';
import 'package:flutter_we/pages/we_page.dart';
import 'package:flutter_we/utils/http_util.dart';

class LoginPage extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        key: _scaffoldKey,
        body: new Stack(children: <Widget>[
          new GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                // _checkInput();
              },
              child: new Container(
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                  //image: new NetworkImage('http://wx4.sinaimg.cn/mw690/74f1d0degy1fvqsvynnv4j20lc0u07gw.jpg'),
                  image: new AssetImage("images/login_signup_background.jpg"),

                  fit: BoxFit.cover,
                  //centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                )),
              )),
          new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
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
          )
        ]));
  }

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

  void _handleSubmitted() {
    bool check = true;

    FocusScope.of(context).requestFocus(new FocusNode());
    _checkInput();
    if (_phoneController.text == '' || _passwordController.text == '') {
      // showMessage(context, "登录信息填写不完整！");
      print("登录信息填写不完整");
      check = false;
    } else if (!_correctPhone || !_correctPassword) {
      //showMessage(context, "登录信息的格式不正确！");
      check = false;
      print("登录信息的格式不正确");
    }

    HttpUtil.login(_passwordController.text,_passwordController.text);

    if (_correctPhone && _correctPassword && check) {
      navigateToMovieDetailPage();
    }
  }

  navigateToMovieDetailPage() {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new WeListPage();
    }));
  }

  void _openSignUp() {
    setState(() {
      Navigator.of(context).push(new MaterialPageRoute<List<String>>(
        builder: (BuildContext context) {
          return new SignUpPage();
        },
      )).then((onValue) {
        if (onValue != null) {
          _phoneController.text = onValue[0];
          _passwordController.text = onValue[1];
          FocusScope.of(context).requestFocus(new FocusNode());
          _scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: new Text("注册成功！"),
          ));
        }
      });
    });
  }
}
