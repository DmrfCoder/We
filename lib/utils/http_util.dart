import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_we/beans/constant_bean.dart' as GlobalBean;
import 'package:flutter_we/beans/edit_bean.dart';
import 'package:flutter_we/beans/edit_list_bean.dart';
import 'package:flutter_we/beans/event_bean.dart';

class HttpUtil {
  //注册
  static signup({String phonenumber, String password}) async {
    String url = "https://api2.bmob.cn/1/users";
    var content = {"password": password, "username": phonenumber};

    var dio = new Dio();

    Response response;

    dio.options.contentType = ContentType.json;
    dio.options.headers["X-Bmob-Application-Id"] = GlobalBean.bmobApplicationId;
    dio.options.headers["X-Bmob-REST-API-Key"] = GlobalBean.bmobRestApiKey;
    dio.options.headers["Content-Type"] = "application/json";

    try {
      response = await dio.post(url, data: content);

      if (response.statusCode == 201) {
        String user_id = response.data["objectId"];

        print("user_id:" + user_id);

        return {"result": true, "user_id": user_id};
      }
    } on DioError catch (e) {
      if (e.response == null) {
        return {"result": false, "error": "注册失败，请检查您的网络！"};
      }

      return {"result": false, "error": e.response.data["error"]};
    }
    return {"result": false};
  }

  static login({String phonenumber, String password}) async {
    String url = "https://api2.bmob.cn/1/login";
    var content = {"username": phonenumber, "password": password};

    var dio = new Dio();

    Response response;

    dio.options.headers["X-Bmob-Application-Id"] = GlobalBean.bmobApplicationId;
    dio.options.headers["X-Bmob-REST-API-Key"] = GlobalBean.bmobRestApiKey;

    try {
      response = await dio.get(url, data: content);
      if (response.statusCode == 200) {
        String user_id = response.data["objectId"];
        String sessionToken = response.data['sessionToken'];
        print(response.data);

        return {
          "result": true,
          "user_id": user_id,
          "sessionToken": sessionToken
        };
      }
    } on DioError catch (e) {
      if (e.response == null) {
        return {"result": false, "error": "登陆失败，请检查您的网络！"};
      }

      return {"result": false, "error": e.response.data["error"]};
    }
    return {"result": false};
  }

  static _uploadfile(String filename, String data) async {
    String url = "https://api2.bmob.cn/2/files/" + filename;

    var dio = new Dio();

    Response response;

    dio.options.contentType = ContentType.text;
    dio.options.headers["X-Bmob-Application-Id"] = GlobalBean.bmobApplicationId;
    dio.options.headers["X-Bmob-REST-API-Key"] = GlobalBean.bmobRestApiKey;
    dio.options.headers["Content-Type"] = "text/plain";

    try {
      response = await dio.post(url, data: data);

      if (response.statusCode == 200) {
        return {"result": true, "url": response.data["url"]};
      }
    } on DioError catch (e) {
      return {"result": false, "error": response.data["error"]};
    }
  }

  static uploadData({TimelineModel timelineModel, String userId}) async {
    String url = "https://api2.bmob.cn/1/classes/MessageData";

    var content = {
      "messageType":
          timelineModel.messageType == GlobalBean.MessageType.nice ? 0 : 1,
      "isDeleted": false,
      "createdTime": timelineModel.time,
      "content": json.encode(timelineModel.editbeanList),
      "userId": userId
    };

    var dio = new Dio();
    dio.interceptor.response.onError = (DioError error) {
      print("error：" + error.toString());
    };

    Response response;

    dio.options.contentType = ContentType.json;

    dio.options.headers["X-Bmob-Application-Id"] = GlobalBean.bmobApplicationId;
    dio.options.headers["X-Bmob-REST-API-Key"] = GlobalBean.bmobRestApiKey;
    dio.options.headers["Content-Type"] = "application/json";

    try {
      response = await dio.post(url, data: content);

      if (response.statusCode == 201) {
        String object_id = response.data["objectId"];
        return {"result": true, "object_id": object_id};
      } else {
        print(response.data);
        print(response.statusCode.toString());
      }
    } on DioError catch (e) {
      print(e.response.data["error"]);
    } catch (e) {
      print(e.toString());
    }

    return {"result": false};
  }

  static _updatePictureUrl(String objectid, String url) async {
    String url = "https://api2.bmob.cn/1/classes/MessageData/";

    url = url + objectid;

    var content = {
      "url": url,
    };

    var dio = new Dio();
    dio.interceptor.response.onError = (DioError error) {
      print("error：" + error.toString());
    };

    Response response;

    dio.options.contentType = ContentType.json;

    dio.options.headers["X-Bmob-Application-Id"] = GlobalBean.bmobApplicationId;
    dio.options.headers["X-Bmob-REST-API-Key"] = GlobalBean.bmobRestApiKey;
    dio.options.headers["Content-Type"] = "application/json";

    try {
      response = await dio.put(url, data: content);

      if (response.statusCode == 200) {
        print("update suucess");
        return {"result": true};
      } else {
        print("update error");
      }
    } on DioError catch (e) {
      print(e.response.data["error"]);
    }

    return {"result": false};
  }

  static downloadData(String userId) async {
    String key = "objectId";

    String url = "https://api2.bmob.cn/1/classes/MessageData";

    var dio = new Dio();
    dio.interceptor.response.onError = (DioError error) {
      print("error：" + error.toString());
    };

    Response response;
    dio.options.headers["X-Bmob-Application-Id"] = GlobalBean.bmobApplicationId;
    dio.options.headers["X-Bmob-REST-API-Key"] = GlobalBean.bmobRestApiKey;
    dio.options.headers["Content-Type"] = "application/json";

    String d = '{"userId":"$userId","isDeleted":false}';

    var content = {"keys": "createdTime,content,messageType,objectId"};

    url = url + "?where=" + d;

    print(url);

    try {
      response = await dio.get(url, data: content);

      if (response.statusCode == 200) {
        String result = response.data["results"].toString();

        List list = response.data["results"];

        List<TimelineModel> timelineModelList = [];

        for (Map value in list) {
          Map timelineModelMap = json.decode(value["content"]);

          String url = value["url"];

          EditbeanList editbeanList =
              new EditbeanList.fromJson(timelineModelMap);

          TimelineModel timelineModel = new TimelineModel(
              time: value["createdTime"],
              editbeanList: editbeanList,
              id: value["objectId"],
              messageType: value["messageType"]);
          timelineModelList.add(timelineModel);
        }

        print(timelineModelList.length);

        return {"result": true, "timelineModelList": timelineModelList};
      } else {
        print("update error");
      }
    } on DioError catch (e) {
      print(e.response.data["error"]);
    }

    return {"result": false};
  }

  static updateData(TimelineModel model) async {
    String url = "https://api2.bmob.cn/1/classes/MessageData/";
    if (model.id == "-1") {
      return {"result": false};
    }
    url = url + model.id;

    var content = {
      "content": json.encode(model.editbeanList),
    };

    var dio = new Dio();
    dio.interceptor.response.onError = (DioError error) {
      print("error：" + error.toString());
    };

    Response response;

    dio.options.contentType = ContentType.json;

    dio.options.headers["X-Bmob-Application-Id"] = GlobalBean.bmobApplicationId;
    dio.options.headers["X-Bmob-REST-API-Key"] = GlobalBean.bmobRestApiKey;
    dio.options.headers["Content-Type"] = "application/json";

    try {
      response = await dio.put(url, data: content);

      if (response.statusCode == 200) {
        print("update suucess");
        return {"result": true};
      } else {
        print("update error");
      }
    } on DioError catch (e) {
      print(e.response.data["error"]);
    }

    return {"result": false};
  }

  static deleteData(String id) async {
    String url = "https://api2.bmob.cn/1/classes/MessageData/";
    url = url + id;

    var content = {
      "isDeleted": false,
    };

    var dio = new Dio();
    dio.interceptor.response.onError = (DioError error) {
      print("error：" + error.toString());
    };

    Response response;

    dio.options.contentType = ContentType.json;

    dio.options.headers["X-Bmob-Application-Id"] = GlobalBean.bmobApplicationId;
    dio.options.headers["X-Bmob-REST-API-Key"] = GlobalBean.bmobRestApiKey;
    dio.options.headers["Content-Type"] = "application/json";

    try {
      response = await dio.put(url, data: content);

      if (response.statusCode == 200) {
        print("update suucess");
        return {"result": true};
      } else {
        print("update error");
      }
    } on DioError catch (e) {
      print(e.response.data["error"]);
    }

    return {"result": false};
  }
}
