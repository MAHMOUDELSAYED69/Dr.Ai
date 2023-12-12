import 'package:shared_preferences/shared_preferences.dart';

class CacheData {
  static late SharedPreferences sharedpref;
  static Future<void> cacheDataInit() async {
    sharedpref = await SharedPreferences.getInstance();
  }
  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      await sharedpref.setString(key, value);
      return true;
    }
    if (value is double) {
      await sharedpref.setDouble(key, value);
      return true;
    }
    if (value is int) {
      await sharedpref.setInt(key, value);
      return true;
    }
    if (value is bool) {
      await sharedpref.setBool(key, value);
      return true;
    }
    return false;
  }

  static dynamic getdata({required String key}) {
    return sharedpref.get(key);
  }

  static void deleteData({required String key}) async {
    await sharedpref.remove(key);
  }

  static Future<bool> clearData({required bool clearData}) async {
    if (clearData == true) {
      await sharedpref.clear();
    }
    return false;
  }
}



