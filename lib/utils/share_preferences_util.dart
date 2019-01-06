import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceUtil {
  static SharePreferenceUtil sharePreferenceUtil = null;

  SharedPreferences sharedPreferences = null;

  static getInstance() async {
    if (sharePreferenceUtil == null) {
      sharePreferenceUtil = new SharePreferenceUtil();
      sharePreferenceUtil.sharedPreferences =
          await SharedPreferences.getInstance();
    }

    return sharePreferenceUtil;
  }

  putString(String key, String value) {
    if (sharedPreferences != null) {
      sharedPreferences.setString(key, value);
    }
  }

  putBool(String key, bool value) {
    if (sharedPreferences != null) {
      sharedPreferences.setBool(key, value);
    }
  }

  getBool(String key) {
    if (sharedPreferences != null) {
      return sharedPreferences.get(key);
    }
  }

  getString(String key) {
    if (sharedPreferences != null) {
      return sharedPreferences.get(key);
    }
  }
}
