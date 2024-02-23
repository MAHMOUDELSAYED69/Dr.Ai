import 'package:dio/dio.dart';
import 'package:dr_ai/core/constant/api_url.dart';
import 'dart:developer';

class PlacesWebservices {
  static Dio dio = Dio();
  //! Fetch Suggetions.
  static Future fetchSuggestions(String place, String sessionToken) async {
    try {
      Response response = await dio.get(
        MyApiUrl.placeSuggetion,
        queryParameters: {
          'input': place,
          'types': 'address',
          'components': 'country:eg',
          'key': MyApiUrl.googleMap,
          'sessiontoken': sessionToken,
        },
      );

      // log(response.data['predictions'].toString());
      // log(response.statusCode.toString());
      // //! DATA MAPING
      // List<dynamic> predictions = response.data['predictions'];
      // List<PlaceSuggestionModel> suggestionList = predictions
      //     .map((prediction) => PlaceSuggestionModel.fromJson(prediction))
      //     .toList();

      return response.data['predictions'];
    } on DioException catch (err) {
      log('Dio Method err:$err');

      return Future.error("Place suggestions error: ",
          StackTrace.fromString("this is the trace"));
    }
  }

  static Future fetchPlaceLocation(String placeId, String sessionToken) async {
    try {
      Response response = await dio.get(
        MyApiUrl.placeSuggetion,
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry',
          'key': MyApiUrl.googleMap,
          'sessiontoken': sessionToken,
        },
      );
      return response.data;
    } on DioException catch (err) {

      log('Dio Method err:$err');
      return Future.error(
          "Place location error: ", StackTrace.fromString("this is the trace"));
    }
  }
}
