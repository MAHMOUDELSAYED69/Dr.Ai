import 'dart:developer';
import 'package:dio/dio.dart';

//! POST
class MessageService {
  static Dio dio = Dio();
  static const String apiUrl = "https://doctorai.pythonanywhere.com/myapp/api/";

  static Future postData({required Map<String, dynamic> data}) async {
    try {
      final response = await dio.post(apiUrl, data: data);
      log('[${response.statusCode}] Data posted successfully!');

      // Message message = Message.fromJson(response.data);
      // log(message.message);
      log("DATA: ${response.data}");
      return response.data['message'];
    } catch (error) {
      log('CATCH: $error');
    }
    return null;
  }
}
