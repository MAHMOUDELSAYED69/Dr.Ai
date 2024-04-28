import 'dart:convert';

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

  static Future<bool> setMapData(
      {required String key, required Map value}) async {
    String jsonString = jsonEncode(value);
    return await sharedpref.setString(key, jsonString);
  }

  static Map<String, dynamic> getMapData({required String key}) {
    String jsonString = sharedpref.getString(key) ?? '{}';
    return jsonDecode(jsonString);
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
