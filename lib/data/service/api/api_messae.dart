import 'dart:developer';
import 'package:dio/dio.dart';

import '../../../core/constant/keys.dart';

//! POST
class MessageService {
  static Dio dio = Dio();

  static Future postData({required Map<String, dynamic> data}) async {
    try {
      final response = await dio.post(MyApiKeys.pyDrAi, data: data);
      log('[${response.statusCode}] Data posted successfully!');
      log("DATA: ${response.data}");
      return response.data['message'];
    } catch (error) {
      log('CATCH: $error');
    }
    return null;
  }
}
