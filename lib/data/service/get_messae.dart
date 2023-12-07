import 'dart:developer';
import 'package:dio/dio.dart';

import '../model/message_model.dart';

class MessageService {
  static Dio dio = Dio();
  static const String apiUrl = "https://doctorai.pythonanywhere.com/myapp/api/";

  static Future<Message?> postData({required Map<String, dynamic> data}) async {
    try {
      final response = await dio.post(apiUrl, data: data);

      log('[${response.statusCode}] Data posted successfully!');

      Message message = Message.fromJson(response.data);
      log(message.message);
      log("DATA: ${response.data['message']}");
      return message;
    } catch (error) {
      log('CATCH: $error');
    }
    return null;
  }
}
// class MessageService {
//   static Dio dio = Dio();
//   static const String apiUrl = "https://doctorai.pythonanywhere.com/myapp/api/";
//   //! POST
//   static Future<Message?> postData({required Map<String, dynamic> data}) async {
//     try {
//       final response = await dio.post(apiUrl, data: data);
//       log('[${response.statusCode}] Data posted successfully!');

//       Message message = Message.fromJson(response.data);
//       log(message.toString());
//       log("DATA:${response.data}"); 
//       return message;
//     } catch (error) {
//       log('CATCH: $error');
//     }
//     return null;
//   }
// }

/**
 * 
  static Future getService({Map<String, dynamic>? queryParameters}) async {
    late Response response;
    try {
      response = await dio.get(path, queryParameters: queryParameters);
      log("[${response.statusCode.toString()}] ${response.data}");
    } on DioException catch (err) {
      log("[${response.statusCode.toString()}] error from dio:$err");
    } catch (err) {
      log("error:$err");
    }
  }




import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  Future<void> callAPI() async {
    Map<String, dynamic> data = {
      'content': 'كسر القدم'
    };

    try {
      final response = await Service.postData(data: data);
      if (response != null) {
        log('Response from API: $response');
        // Handle the response here
      }
    } catch (error) {
      log('Error calling API: $error');
      // Handle errors here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          callAPI();
        },
        child: Text('Call API'),
      ),
    );
  }
}

class Service {
  static Dio dio = Dio();
  static const String path = "https://doctorai.pythonanywhere.com/myapp/api/";

  static Future postData({required Map<String, dynamic> data}) async {
    try {
      final response = await dio.post(path, data: data);
      if (response.statusCode == 200) {
        log('Data posted successfully');
        return response.data;
      } else {
        log('[${response.statusCode}] Failed to post data. Error!');
        throw Exception('Failed to post data. Error!');
      }
    } catch (error) {
      log('An error occurred: $error');
      throw error;
    }
  }
} * 
 */