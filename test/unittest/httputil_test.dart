import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_we/beans/constant_bean.dart';
import 'package:flutter_we/beans/data_responseinfo_bean.dart';
import 'package:flutter_we/beans/edit_list_bean.dart';
import 'package:flutter_we/beans/event_bean.dart';
import 'package:flutter_we/beans/events_bean.dart';
import 'package:flutter_we/utils/http_util.dart';

void main() {
  test("down load data  test", () async {
    DataResponseInfoBean dataResponseInfoBean =
        await HttpUtil.downloadData("a32caf3cac");

    Map map = dataResponseInfoBean.datdaContent;

    map.forEach((key, value) {
      print("key:$key value:$value");
      //  Map<String,dynamic> map2=json.decode(value.toString());
      // print(value["content"]);
      // print(value["createdTime"]);
      Map timelineModelMap = json.decode(value["content"]);
      EditbeanList timelineModel = new EditbeanList.fromJson(timelineModelMap);
      print(timelineModel.list.length);
    });
  });

  test("up load data  test", () async {
    DataResponseInfoBean dataResponseInfoBean = await HttpUtil.uploadData(
        userId: "a32caf3cac",
        timelineModel: new TimelineModel(
            editbeanList: new EditbeanList(),
            time: "2018-10-15 18:52",
            messageType: MessageType.nice));

    if (dataResponseInfoBean == null) {
      print("response is null");
      return;
    } else {
      if (dataResponseInfoBean.result) {
        print("success");
      } else {
        print("faild");
      }
    }
  });

  test("up laod picture message", () async {
    File imagefile = new File(
        "/Users/dmrfcoder/demo.jpeg");

    List<int> imageBytes = imagefile.readAsBytesSync();

    String imageDatastr = base64Encode(imageBytes);
    var filecontent={
      "name":"a.png",
      "body":imageDatastr
    };









    var content = {"content": filecontent};

    //FormData formData=FormData.from(content);

   // print(formData.toString());

    String url = "http://javacloud.bmob.cn/ff9f06fde1813232/uploadPictureDemo";

    Response response = await HttpUtil.demo(url, content);

    if (response == null) {
      return new DataResponseInfoBean(result: false);
    } else {
      print(response.data.toString());
    }


  });
}
