import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_we/callback/add_todo_work_callback.dart';
import 'package:flutter_we/pages/add_todo_work_page.dart';
import 'package:flutter_we/pages/todo_work_page.dart';

class ManageTodoWorkPage extends StatefulWidget {
  List<Event> events;
  DateTime dateTime;
  AddToDoEventCallBack addToDoEventCallBack;

  ManageTodoWorkPage(this.events, this.dateTime, this.addToDoEventCallBack);

  @override
  State<StatefulWidget> createState() => new ManageTodoWorkState();
}

class ManageTodoWorkState extends State<ManageTodoWorkPage>
    implements AddToDoWorkCallBack {
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000.0)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  @override
  addSuccess(String content) {
    // TODO: implement addSuccess

    Event event = new Event(
      date: widget.dateTime,
      title: content,
      icon: _eventIcon,
    );

    widget.addToDoEventCallBack.addEventSuccess(event);

    setState(() {
      widget.events.add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        actions: <Widget>[_buildAddToDoWidget()],
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
          new Container(
            margin: EdgeInsets.all(10.0),
            child: widget.events.length == 0
                ? new Text("该日没有需完成的工作，您可向该日添加工作")
                : new ListView.builder(
                    itemBuilder: (BuildContext context, int position) {
                      return _buildItem(widget.events[position]);
                    },
                    itemCount: widget.events.length,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(Event event) {
    var row = new Container(
      margin: EdgeInsets.all(4.0),
      child: Row(children: <Widget>[
        new ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: event.icon,
        ),
        new Expanded(
          child: new Container(
            margin: EdgeInsets.only(left: 8.0),
            height: 50.0,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  event.date.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                new Text(
                  event.title,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        )
      ]),
    );

    return new Card(
      child: row,
    );
  }

  _buildAddToDoWidget() {
    var c = new Container(
      width: 80.0,
      padding: const EdgeInsets.all(8.0),
      child: new IconButton(
        onPressed: OnAdd,
        icon: Icon(
          Icons.add,
          color: Colors.pink,
        ),
      ),
    );

    return c;
  }

  void OnAdd() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new AddToDoWorkPage(widget.dateTime, this);
    }));
  }
}
