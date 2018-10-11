import 'dart:io';

import 'package:dio/dio.dart';

class HttpUtil {
  static _post(String url, FormData content) async {
    Dio dio = new Dio();

    var response = await dio.post("/info", data: content);


    return response;

  }

  static signup() {
    String usrl = "http://javacloud.bmob.cn/bb2c29a77a076bc9/signUp";

    FormData formData = new FormData.from({
      "username": "username_from_ios",
      "password": "demopassword",
    });

    var response=_post(usrl, formData);

    print(response.data.toString());
  }
}
