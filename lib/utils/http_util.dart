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
  static _post(String url, var content) async {
    var dio = new Dio();
    dio.interceptor.response.onError = (DioError error) {
      print("error："+error.toString());
      //print(error.response.statusCode);
    };

    Response r;
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 5000;
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
    String url = "http://javacloud.bmob.cn/ff9f06fde1813232/signUp";

    var c = {
      "username": nickname,
      "phonenumber": phonenumber,
      "password": password
    };

    Response response = await _post(url, c);

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
    Response response = await _post(url, c);

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


    var c = {"userId": userId, "time": time, "content": content};

    Response response = await _post(url, c);

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

    Response response = await _post(url, c);
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

    Response response = await _post(url, c);
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

    Response response = await _post(url, c);

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
}
