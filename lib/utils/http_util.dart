import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

class HttpUtil {
  static _post(String url, var content) async {
    var dio = new Dio();
    dio.interceptor.response.onError = (DioError error) {
      print(error);
      print(error.response.statusCode);
    };
    Response r;
    try {
      r = await dio.post(url, data: content);
      print(r);
    } on DioError catch (e) {
      print(e);
      print(e.response.statusCode);
    }

    return r;
  }

  static signup(String phonenumber, String password, String nickname) {
    String usrl = "http://javacloud.bmob.cn/bb2c29a77a076bc9/signUp";

    var c = {"username": phonenumber, "password": password};

    var response = _post(usrl, c);

    print(response);
  }

  static login(String phonenumber, String password) {
    String usrl = "http://javacloud.bmob.cn/bb2c29a77a076bc9/logIn";

    var c = {"username": phonenumber, "password": password};

    var response = _post(usrl, c);

    print(response);
  }
}
