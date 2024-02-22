import 'package:dio/dio.dart';
import 'package:dr_ai/core/constant/keys.dart';
import 'dart:developer';

//! GET
class PlacesWebservices {
  static Dio dio = Dio();

  static Future<List<dynamic>> fetchSuggestions(
      String place, String sessionToken) async {
    try {
      Response response = await dio.get(
        MyApiKeys.placeSuggetion,
        queryParameters: {
          'input': place,
          'types': 'address',
          'components': 'country:eg',
          'key': MyApiKeys.googleMap,
          // 'sessiontoken': sessionToken
        },
      );
      log(response.data['predictions'].toString());
      log(response.statusCode.toString());
      return response.data['predictions'];
    } on DioException catch (err) {
      log(err.toString());
      return [];
    }
  }
}
