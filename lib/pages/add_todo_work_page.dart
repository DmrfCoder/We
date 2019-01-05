import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_we/callback/add_todo_work_callback.dart';

class AddToDoWorkPage extends StatefulWidget {
  DateTime dateTime;
  AddToDoWorkCallBack addToDoWorkCallBack;

  AddToDoWorkPage(this.dateTime, this.addToDoWorkCallBack);

  @override
  State<StatefulWidget> createState() => new AddToDoWorkState();
}

class AddToDoWorkState extends State<AddToDoWorkPage> {
  TextEditingController contentController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    String strTime = widget.dateTime.toString();
    List<String> times = strTime.split(" ");
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text(times[0]),
        actions: <Widget>[_buildSaveWidget()],
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
          new Row(
            children: <Widget>[
              Expanded(
                child: new Text(""),
                flex: 1,
              ),
              Expanded(
                child: new TextField(
                  controller: contentController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.black87,
                  ),
                  keyboardType: TextInputType.text,
                  autofocus: true,
                ),
                flex: 18,
              ),
              Expanded(
                child: new Text(""),
                flex: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildSaveWidget() {
    var c = new Container(
      width: 80.0,
      padding: const EdgeInsets.all(8.0),
      child: new IconButton(
        onPressed: OnSave,
        icon: Icon(
          Icons.save,
          color: Colors.pink,
        ),
      ),
    );

    return c;
  }

  void OnSave() {
    if (contentController.text != "") {
      widget.addToDoWorkCallBack.addSuccess(contentController.text);
    }

    Navigator.pop(context);
  }
}
