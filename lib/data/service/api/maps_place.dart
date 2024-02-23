import 'package:dio/dio.dart';
import 'package:dr_ai/core/constant/api_url.dart';
import 'dart:developer';

class PlacesWebservices {
  static Dio dio = Dio();
  //! Fetch Suggetions.
  static Future fetchPlaceSuggestions(String place, String sessionToken) async {
    try {
      Response response = await dio.get(
        MyApiUrl.placeSuggetion,
        queryParameters: {
          'radius': 5000,
          'input': place,
          'types': 'hospital',
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
    } on DioException {
      return Future.error("Place suggestions error: ",
          StackTrace.fromString("this is the trace"));
    } catch (err) {
      log('Dio Method err:$err');
    }
  }

  //! fetch Location
  static Future fetchPlaceLocation(String placeId, String sessionToken) async {
    try {
      Response response = await dio.get(
        MyApiUrl.placeLocation,
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry',
          'key': MyApiUrl.googleMap,
          'sessiontoken': sessionToken,
        },
      );
      return response.data;
    } on DioException {
      return Future.error(
          "Place location error: ", StackTrace.fromString("this is the trace"));
    } catch (err) {
      log('Dio Method err:$err');
    }
  }
}
