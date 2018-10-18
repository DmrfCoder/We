import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/beans/edit_bean.dart';
import 'package:flutter_we/beans/event_bean.dart';
import 'package:flutter_we/callback/addprojet_callback.dart';
import 'package:flutter_we/callback/timelinemodeledit_callback.dart';
import 'package:flutter_we/controllor/editor_controllor.dart';
import 'package:flutter_we/pages/exportmessage_page.dart';
import 'package:flutter_we/utils/http_util.dart';
import 'package:flutter_we/widgets/editor_widget.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;

class AddProjectPage extends StatefulWidget {
  TimelineModel timelineModel;

  TimeLineModelEditCallBack _timeLineModelEditCallBack;

  EditType editType;

  AddProjectPage(
      this.timelineModel, this._timeLineModelEditCallBack, this.editType);

  @override
  State<StatefulWidget> createState() => new AddprojectState();
}

class AddprojectState extends State<AddProjectPage>
    implements AddProjectPageCallBack {
  File _imageFile;

  void captureImage(ImageSource captureMode) async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    _imageFile = imageFile;

    if (_imageFile == null) {
      return;
    }
    List<int> imageBytes = _imageFile.readAsBytesSync();

    String imageData = base64Encode(imageBytes);

    _editorControllor.addPicture(imageData);
  }

  EditorControllor _editorControllor;

  GlobalKey _globalKey = new GlobalKey();

  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      // var bs64 = base64Encode(pngBytes);

      _navigateToExportMessagePage(pngBytes);
    } catch (e) {
      print(e);
    }
  }

  _navigateToExportMessagePage(Uint8List imagebytes) {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new ExportMessagePage(
        imageBytes: imagebytes,
      );
    }));
  }

  void onClear() {
    setState(() {
      _editorControllor.clear();
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    _editorControllor = new EditorControllor(widget._timeLineModelEditCallBack,
        widget.timelineModel, widget.editType);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var content = _BuildPage();

    return new Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: new AppBar(
        title: new Text('we'),
        actions: <Widget>[_BuildInsertPicture(), _BuildSaveButton()],
      ),
      body: new RepaintBoundary(
        key: _globalKey,
        child: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new ExactAssetImage('images/edit_back.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: new Editor(
            addProjectPageCallBack: this,
            list: _editorControllor.getDataList(),
            needAutoFocus: widget.editType == EditType.add ? true : false,
          ),
        ),
      ),
    );
  }

  _BuildPage() {
    var c = new Column(
      children: <Widget>[
        new Editor(
          addProjectPageCallBack: this,
          list: _editorControllor.getDataList(),
          needAutoFocus: widget.editType == EditType.add ? true : false,
        ),
      ],
    );
    return c;
  }

  _BuildInsertPicture() {
    var c = new Container(
      width: 80.0,
      child: new IconButton(
          icon: Icon(
            Icons.picture_in_picture,
            color: Colors.pink,
          ),
          onPressed: () {
            //做选择图片的操作
            captureImage(null);
          }),
    );

    return c;
  }

  _BuildSaveButton() {
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
    _editorControllor.dispose();
    //onClear();
    Navigator.pop(context);
  }

  @override
  deleteEditbean(EditBean editbean) {
    // TODO: implement deleteEditbean
    _editorControllor.deleteEditbean(editbean);
    updateWidget();
  }

  @override
  updateEditbean(EditBean editbean) {
    // TODO: implement updateEditbean
    _editorControllor.updateEditbean(editbean);
  }

  @override
  updateCurEditbean(EditBean curEditbean) {
    // TODO: implement updateCurEditbean
    _editorControllor.updateCurEditbean(curEditbean);
  }

  updateWidget() {
    setState(() {});
  }
}
