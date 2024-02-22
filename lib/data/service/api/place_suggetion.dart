import 'package:dio/dio.dart';
import 'package:dr_ai/core/constant/keys.dart';
import 'dart:developer';

import '../../model/place_suggetion.dart';

class PlacesWebservices {
  static Dio dio = Dio();

  static Future<List<PlaceSuggestionModel>> fetchSuggestions(
      String place, String sessionToken) async {
    try {
      Response response = await dio.get(
        MyApiKeys.placeSuggetion,
        queryParameters: {
          'input': place,
          'types': 'address',
          'components': 'country:eg',
          'key': MyApiKeys.googleMap,
          'sessiontoken': sessionToken,
        },
      );

      log(response.data['predictions'].toString());
      log(response.statusCode.toString());

      List<dynamic> predictions = response.data['predictions'];
      List<PlaceSuggestionModel> suggestionList = predictions
          .map((prediction) => PlaceSuggestionModel.fromJson(prediction))
          .toList();

      return suggestionList;
    } on DioException catch (err) {
      log(err.toString());
      return [];
    }
  }
}