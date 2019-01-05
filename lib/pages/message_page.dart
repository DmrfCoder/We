import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MessageState();
}

class _MessageState extends State<MessagePage> {
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
      ]),
    );
  }
}
