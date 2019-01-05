import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExportMessagePage extends StatefulWidget {
  Uint8List imageBytes;

  ExportMessagePage({this.imageBytes});

  @override
  State<StatefulWidget> createState() => new _ExportMessagePageState();
}

class _ExportMessagePageState extends State<ExportMessagePage> {
  Image _exportImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _exportImage = Image.memory(widget.imageBytes);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("导出结果"),
      ),
      body: _exportImage,
    );
  }
}
