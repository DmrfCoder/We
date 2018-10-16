import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_we/beans/data_responseinfo_bean.dart';
import 'package:flutter_we/beans/event_bean.dart';
import 'package:flutter_we/beans/user_responseinfo_bean.dart';

class HttpUtil {
  static post(String url, var content) async {
    var dio = new Dio();
    dio.interceptor.response.onError = (DioError error) {
      print("error：" + error.toString());
    };




    Response r;

    dio.options.contentType = ContentType.json;
    dio.options.headers["X-Bmob-Application-Id"] = "2b3b0a7931e05ebe9c91ea8163d06bdf";
    dio.options.headers["X-Bmob-REST-API-Key"] = "9b8adb6074b122558d490c9807a6d903";
    dio.options.headers["Content-Type"] = "application/json";


    try {
      r = await dio.post(url, data: content);
    } on DioError catch (e) {
      // return e;
      print(e);
      // print(e.response.statusCode);
    }

    return r;
  }

  //注册
  static signup({String phonenumber, String password, String nickname}) async {
    String url = "https://api2.bmob.cn/1/users";

    var c = {
      "username": nickname,
      "mobilePhoneNumber": phonenumber,
      "password": password
    };

    Response response = await post(url, c);

    if (response == null) {
      return new DataResponseInfoBean(result: false);
    }
    UserResponseInfoBean responseInfoBean;

    responseInfoBean = new UserResponseInfoBean(
        result: response.data["result"],
        userid: response.data["userid"],
        desc: response.data["desc"]);

    return responseInfoBean;
  }

  static login({String phonenumber, String password}) async {
    String url = "http://javacloud.bmob.cn/ff9f06fde1813232/logIn";

    var c = {"phonenumber": phonenumber, "password": password};
    Response response = await post(url, c);

    if (response == null) {
      return new DataResponseInfoBean(result: false);
    }

    UserResponseInfoBean responseInfoBean;
    responseInfoBean = new UserResponseInfoBean(
        result: response.data["result"],
        desc: response.data["desc"],
        userid: response.data["userid"]);

    return responseInfoBean;
  }

  static uploadData({TimelineModel timelineModel, String userId}) async {
    String url = "http://javacloud.bmob.cn/ff9f06fde1813232/addData";

    String time = timelineModel.time;
    String content = json.encode(timelineModel.editbeanList);

    var c = {
      "userId": userId,
      "time": time,
      "content": content,
      "messageType": timelineModel.messageType.index
    };

    Response response = await post(url, c);

    if (response == null) {
      return new DataResponseInfoBean(result: false);
    }

    DataResponseInfoBean dataResponseInfoBean;
    dataResponseInfoBean = new DataResponseInfoBean(
        result: response.data["result"],
        desc: response.data["desc"],
        objectId: response.data["objectId"]);

    return dataResponseInfoBean;
  }

  static downloadData(String userId) async {
    String url = "http://javacloud.bmob.cn/ff9f06fde1813232/downLoadData";

    var c = {"userId": userId};

    Response response = await post(url, c);
    if (response == null) {
      return new DataResponseInfoBean(result: false);
    }
    DataResponseInfoBean dataResponseInfoBean;
    dataResponseInfoBean = new DataResponseInfoBean(
        result: response.data["result"],
        desc: response.data["desc"],
        datdaContent: response.data["dataContent"]);

    return dataResponseInfoBean;
  }

  static updateData(TimelineModel model) async {
    String url = "http://javacloud.bmob.cn/ff9f06fde1813232/updateData";

    var c = {"objectId": model.id, "content": json.encode(model.editbeanList)};

    Response response = await post(url, c);
    if (response == null) {
      return new DataResponseInfoBean(result: false);
    }

    DataResponseInfoBean dataResponseInfoBean;
    dataResponseInfoBean = new DataResponseInfoBean(
      result: response.data["result"],
      desc: response.data["desc"],
    );

    return dataResponseInfoBean;
  }

  static deleteData(String id) async {
    String url = "http://javacloud.bmob.cn/ff9f06fde1813232/deleteData";

    var c = {"objectId": id};

    Response response = await post(url, c);

    if (response == null) {
      return new DataResponseInfoBean(result: false);
    }
    DataResponseInfoBean dataResponseInfoBean;

    dataResponseInfoBean = new DataResponseInfoBean(
      result: response.data["result"],
      desc: response.data["desc"],
    );

    return dataResponseInfoBean;
  }

  static demo(url, content) async {
    Response response = await post(url, content);

    return response;
  }
}
