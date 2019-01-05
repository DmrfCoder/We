import 'dart:io';

import 'package:flutter_we/beans/constant_bean.dart' as GlobalBean;
import 'package:dio/dio.dart';

class MarryUtil {
  static cancel_Associate({String userid}) async {
    String url = "https://api2.bmob.cn/1/users/" + userid;

    var content = {"isMarried": false};

    var dio = new Dio();
    dio.interceptor.response.onError = (DioError error) {
      print("error：" + error.toString());
    };

    Response response;

    dio.options.contentType = ContentType.json;

    dio.options.headers["X-Bmob-Application-Id"] = GlobalBean.bmobApplicationId;
    dio.options.headers["X-Bmob-REST-API-Key"] = GlobalBean.bmobRestApiKey;
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.headers["X-Bmob-Master-Key"] = GlobalBean.bmobMasterKey;

    try {
      response = await dio.put(url, data: content);

      if (response.statusCode == 200) {
        print("success");
        return {"result": true};
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

  static associate_User(
      {String myUserId, String otherUserPhone, String sessionToken}) async {
    String url = "https://api2.bmob.cn/1/users/" + myUserId;

    var content = {
      "WaitMarrayUser": otherUserPhone,
      "MarriedUser": otherUserPhone,
      "isMarried": true
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
    dio.options.headers["X-Bmob-Master-Key"] = GlobalBean.bmobMasterKey;

    try {
      response = await dio.put(url, data: content);

      if (response.statusCode == 200) {
        print("success");
        return {"result": true};
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

  static Inquire({String userId}) async {
    String url = "https://api2.bmob.cn/1/users/" + userId;

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
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e.response.data["error"]);
    } catch (e) {
      print(e.toString());
    }
  }

  static getUserIdByUserName(String userName) async {
    String key = "objectId";

    String url = "https://api2.bmob.cn/1/users/";

    var dio = new Dio();
    dio.interceptor.response.onError = (DioError error) {
      print("error：" + error.toString());
    };

    Response response;
    dio.options.headers["X-Bmob-Application-Id"] = GlobalBean.bmobApplicationId;
    dio.options.headers["X-Bmob-REST-API-Key"] = GlobalBean.bmobRestApiKey;
    dio.options.headers["Content-Type"] = "application/json";

    String d = '{"username":"$userName"}';

    url = url + "?where=" + d;

    print(url);

    try {
      response = await dio.get(url);
      String a = response.data["results"].toString();
      try {
        List list = response.data["results"];
        print("getUserIdByUserName:");
        print(response.data);
        return list[0]['objectId'];
      } catch (e) {
        return "false";
      }

    } on DioError catch (e) {
      print(e.response.data["error"]);
    }

    return {"result": false};
  }
}
