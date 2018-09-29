import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_we/beans/event_bean.dart';
import 'package:flutter_we/controllor/editor_controllor.dart';
import 'package:flutter_we/utils/image_picker_channel_util.dart';
import 'package:flutter_we/widgets/editor_widget.dart';
class AddProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new AddprojectState();
}

class AddprojectState extends State<AddProjectPage> {
  ImagePicker _imagePicker = new ImagePickerChannel();

  File _imageFile;

  void updateData() {
    setState(() {});
  }

  void captureImage(ImageSource captureMode) async {
    try {
      var imageFile = await _imagePicker.pickImage(imageSource: captureMode);
      setState(() {
        _imageFile = imageFile;
        editorControllor.addPicture(_imageFile);
      });
    } catch (e) {
      print(e);
    }
  }

  //时间输入框的控制器
  TextEditingController _timrController = new TextEditingController();

  //内容输入框的控制器
  TextEditingController _contentController = new TextEditingController();

  EditorControllor editorControllor = new EditorControllor();

  DateTime now = new DateTime.now();

  void onTextClear() {
    setState(() {
      _timrController.text = "";
      _contentController.text = "";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var content = _BuildPage();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('wjy同學'),
        actions: <Widget>[_BuildInsertPicture(), _BuildSaveButton()],
      ),
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('images/edit_back.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: content,
      ),
    );
  }

  _BuildPage() {
    var c = new Column(
      children: <Widget>[
        new Editor(editorControllor, this),
      ],
    );
    return c;
  }

  _BuildInsertPicture() {
    var c = new Container(
      width: 80.0,
      child: new IconButton(
          icon: Icon(Icons.picture_in_picture),
          onPressed: () {
            //做选择图片的操作
            captureImage(ImageSource.photos);
          }),
    );

    return c;
  }

  _BuildSaveButton() {
    var c = new Container(
      width: 80.0,
      padding: const EdgeInsets.all(8.0),
      child: new RaisedButton(
          onPressed: () {
            String cont = _contentController.text.toString();

            OnSave(now.toString(), cont);

            onTextClear();
          },
          color: Colors.blue,
          //highlightColor: Colors.lightBlueAccent,
          //disabledColor: Colors.lightBlueAccent,
          child: new Text(
            "提交",
            style: new TextStyle(color: Colors.white),
          )),
    );

    return c;
  }

  Widget _buildImage() {
    if (_imageFile != null) {
      return new Image.file(_imageFile);
    } else {
      return new Text('Take an image to start',
          style: new TextStyle(fontSize: 18.0));
    }
  }

  void OnSave(String t, String cont) {
    if (cont.isEmpty) {
      return;
    }
    TimelineModel timelineModel = new TimelineModel(t, cont, "这是标题");
    String js = json.encode(timelineModel);
//    FileIo.save(js);
    eventBus.fire(timelineModel);
    //print(js);
    Navigator.pop(context);
  }
}
