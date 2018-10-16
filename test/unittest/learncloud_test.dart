import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_we/beans/edit_list_bean.dart';
import 'package:flutter_we/beans/event_bean.dart';
import 'package:flutter_we/utils/http_util.dart';
import 'package:test/test.dart';

import 'package:http/http.dart' as http;

void main() {
  test("sign up test", () async {
    String url = "https://api2.bmob.cn/1/users";
    var content = {"password": "319319", "username": "15651808915"};

    var dio = new Dio();


    Response response;

    dio.options.contentType = ContentType.json;
    dio.options.headers["X-Bmob-Application-Id"] =
        "2b3b0a7931e05ebe9c91ea8163d06bdf";
    dio.options.headers["X-Bmob-REST-API-Key"] =
        "9b8adb6074b122558d490c9807a6d903";
    dio.options.headers["Content-Type"] = "application/json";

    try {
      response = await dio.post(url, data: content);

      print(response.statusCode.toString());
      if (response.statusCode == 201) {
        String user_id = response.data["objectId"];
        print("user_id:" + user_id);
      }
    } on DioError catch (e) {
      print(e.response.data["error"]);
    }
  });

  test("login test", () async {
    String url = "https://api2.bmob.cn/1/login";
    var content = {"username": "15651808915", "password": "dedede"};

    var dio = new Dio();
    dio.interceptor.response.onError = (DioError error) {
      print("error：" + error.toString());
    };

    Response response;

    dio.options.headers["X-Bmob-Application-Id"] =
        "2b3b0a7931e05ebe9c91ea8163d06bdf";
    dio.options.headers["X-Bmob-REST-API-Key"] =
        "9b8adb6074b122558d490c9807a6d903";

    try {
      response = await dio.get(url, data: content);
      if (response.statusCode == 200) {
        String user_id = response.data["objectId"];
        print("user_id:" + user_id);
      }
    } on DioError catch (e) {
      print(e.response.data["error"]);
    }
  });

  test("upload pic test", () async {
    File imagefile = new File("/Users/dmrfcoder/demo.jpeg");

    List<int> imageBytes = imagefile.readAsBytesSync();

    String imageDatastr = base64Encode(imageBytes);

    String url = "https://api2.bmob.cn/2/files/demo.txt";

    var dio = new Dio();
    dio.interceptor.response.onError = (DioError error) {
      print("error：" + error.toString());
    };

    Response response;

    dio.options.contentType = ContentType.text;
    dio.options.headers["X-Bmob-Application-Id"] =
        "2b3b0a7931e05ebe9c91ea8163d06bdf";
    dio.options.headers["X-Bmob-REST-API-Key"] =
        "9b8adb6074b122558d490c9807a6d903";
    dio.options.headers["Content-Type"] = "text/plain";

    try {
      response = await dio.post(url, data: imageDatastr);

      if (response.statusCode == 200) {
        print(response.data["url"]);
      }
    } on DioError catch (e) {
      print(e.response.data["error"]);
    }
  });

  test("down load pic test", () async {
    String url =
        "http://bmob-cdn-21895.b0.upaiyun.com/2018/10/16/46040f5d40f6a16e8080ef2b7471c37e.txt";

    var dio = new Dio();
    dio.interceptor.response.onError = (DioError error) {
      print("error：" + error.toString());
    };

    Response response;

    try {
      response = await dio.get(url);

      String picturedata = response.data.toString();
      List<int> imageBytes = base64Decode(picturedata);

      print(response.data.toString());
    } on DioError catch (e) {
      print(e.response.data["error"]);
    }
  });

  test("insert message test", () async {
    String url = "https://api2.bmob.cn/1/classes/MessageData";
    var content = {
      "userid": "3011957a20",
      "messageType": 0,
      "isDeleted": false,
      "content": "test content",
      "createdTime": "test time"
    };

    var dio = new Dio();
    dio.interceptor.response.onError = (DioError error) {
      print("error：" + error.toString());
    };

    Response response;

    dio.options.contentType = ContentType.json;

    dio.options.headers["X-Bmob-Application-Id"] =
        "2b3b0a7931e05ebe9c91ea8163d06bdf";
    dio.options.headers["X-Bmob-REST-API-Key"] =
        "9b8adb6074b122558d490c9807a6d903";
    dio.options.headers["Content-Type"] = "application/json";

    try {
      response = await dio.post(url, data: content);

      if (response.statusCode == 201) {
        String object_id = response.data["objectId"];
        print("object_id:" + object_id);
      }
    } on DioError catch (e) {
      print(e.response.data["error"]);
    }
  });

  test("update message test", () async {
    String url = "https://api2.bmob.cn/1/classes/MessageData/5dd543d235";
    var content = {"isDeleted": true};

    var dio = new Dio();
    dio.interceptor.response.onError = (DioError error) {
      print("error：" + error.toString());
    };

    Response response;

    dio.options.contentType = ContentType.json;

    dio.options.headers["X-Bmob-Application-Id"] =
        "2b3b0a7931e05ebe9c91ea8163d06bdf";
    dio.options.headers["X-Bmob-REST-API-Key"] =
        "9b8adb6074b122558d490c9807a6d903";
    dio.options.headers["Content-Type"] = "application/json";

    try {
      response = await dio.put(url, data: content);

      if (response.statusCode == 200) {
        print("update suucess");
      } else {
        print("update error");
      }
    } on DioError catch (e) {
      print(e.response.data["error"]);
    }
  });

  test("chaxun message test", () async {
    String key = "objectId";
    String value = "3011957a20";

    String url = "https://api2.bmob.cn/1/classes/MessageData";

    var dio = new Dio();
    dio.interceptor.response.onError = (DioError error) {
      print("error：" + error.toString());
    };

    Response response;
    dio.options.headers["X-Bmob-Application-Id"] =
        "2b3b0a7931e05ebe9c91ea8163d06bdf";
    dio.options.headers["X-Bmob-REST-API-Key"] =
        "9b8adb6074b122558d490c9807a6d903";
    dio.options.headers["Content-Type"] = "application/json";

    String id = "3011957a20";
    String d = '{"userId":"$id","isDeleted":false}';

    var content = {"keys": "createdTime,content,messageType,objectId"};

    url = url + "?where=" + d;

    print(url);

    try {
      response = await dio.get(url, data: content);

      if (response.statusCode == 200) {
        print("update suucess");
        String result = response.data["results"].toString();

        List list = response.data["results"];
        print(list.length.toString());

        List lists = [];

        for (Map value in list) {
          Map timelineModelMap = json.decode(value["content"]);

          EditbeanList editbeanList =
              new EditbeanList.fromJson(timelineModelMap);

          TimelineModel timelineModel = new TimelineModel(
              time: value["createdTime"],
              editbeanList: editbeanList,
              id: value["objectId"],
              messageType: value["messageType"]);
          lists.add(timelineModel);
        }

        print(lists.length.toString());
      } else {
        print("update error");
      }
    } on DioError catch (e) {
      print(e.response.data["error"]);
    }
  });
}
