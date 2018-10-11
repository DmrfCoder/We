import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();

  //final reference = FirebaseDatabase.instance.reference().child('users');
  bool _correctPhone = true;
  bool _correctUsername = true;
  bool _correctPassword = true;

  void _handleSubmitted() {
    FocusScope.of(context).requestFocus(new FocusNode());
    _checkInput();
    if (_usernameController.text == '' || _passwordController.text == '') {
      // showMessage(context, "注册信息填写不完整！");
      print("注册信息填写不完整");
      return;
    } else if (!_correctUsername || !_correctPassword || !_correctPhone) {
      //showMessage(context, "注册信息的格式不正确！");
      print("注册信息的格式不正确");
      return;
    }
  }

  void _checkInput() {
    if (_phoneController.text.isNotEmpty &&
        (_phoneController.text.trim().length < 7 ||
            _phoneController.text.trim().length > 12)) {
      _correctPhone = false;
    } else {
      _correctPhone = true;
    }
    if (_usernameController.text.isNotEmpty &&
        _usernameController.text.trim().length < 2) {
      _correctUsername = false;
    } else {
      _correctUsername = true;
    }
    if (_passwordController.text.isNotEmpty &&
        _passwordController.text.trim().length < 6) {
      _correctPassword = false;
    } else {
      _correctPassword = true;
    }
    setState(() {});
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
            new BackButton(),
            new Text(
              "  注册账户",
              textScaleFactor: 2.0,
            ),
            new Container(
                width: MediaQuery.of(context).size.width * 0.96,
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: new InputDecoration(
                          hintText: '手机号码',
                          errorText: _correctPhone ? null : '号码的长度应该在7到12位之间',
                          icon: new Icon(
                            Icons.phone,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        onSubmitted: (value) {
                          _checkInput();
                        },
                      ),
                      new TextField(
                        controller: _usernameController,
                        decoration: new InputDecoration(
                          hintText: '用户名称',
                          errorText: _correctUsername ? null : '名称的长度应该大于2位',
                          icon: new Icon(
                            Icons.account_circle,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        onSubmitted: (value) {
                          _checkInput();
                        },
                      ),
                      new TextField(
                        controller: _passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          hintText: '密码',
                          errorText: _correctPassword ? null : '密码的长度需大于6位',
                          icon: new Icon(
                            Icons.lock_outline,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        onSubmitted: (value) {
                          _checkInput();
                        },
                      ),
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
              child: new Text("已经有账户了？ 登录"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ))
          ])
    ]));
  }
}
