import 'dart:developer';
import 'package:dio/dio.dart';

import '../../../core/constant/api_url.dart';

//! POST
class MessageWebService {
  static Dio dio = Dio();

  static Future postData({required Map<String, dynamic> data}) async {
    try {
      final response = await dio.post(MyApiUrl.pyDrAi, data: data);

      log('[${response.statusCode}] Data posted successfully!');
      log("DATA: ${response.data}");

      return response.data['message'];
    } on DioException {
      return Future.error(
          "pyDrAi error: ", StackTrace.fromString("this is the trace"));
    } catch (err) {
      log(err.toString());
    }
  }
}
