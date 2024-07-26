import 'dart:convert';

import 'package:intl/intl.dart';
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

  static Future<bool> setListOfMaps(
      {required String key, required List<Map<String, dynamic>> value}) async {
    String jsonString = jsonEncode(value);
    return await sharedpref.setString(key, jsonString);
  }

  static List<Map<String, dynamic>> getListOfMaps({required String key}) {
    String jsonString = sharedpref.getString(key) ?? '[]';
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => e as Map<String, dynamic>).toList();
  }

  static Future<void> setLastUpdatedTime(String key) async {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm a');
    String formattedDate = formatter.format(now);
    await sharedpref.setString(key, formattedDate);
  }

  static String? getLastUpdatedTime(String key) {
    return sharedpref.getString(key);
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
