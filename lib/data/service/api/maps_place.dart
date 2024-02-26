import 'package:dio/dio.dart';
import 'package:dr_ai/core/constant/api_url.dart';
import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';

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
   //! get destination
  static Future getPlaceDirections(LatLng origin, LatLng destination) async {
    try {
      Response response = await dio.get(
        MyApiUrl.directions,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': MyApiUrl.googleMap, 
        },
      );
      return response.data;
    } on DioException {
      return Future.error("Place destination error: ",
          StackTrace.fromString("this is the trace"));
    } catch (err) {
      log('Dio Method err:$err');
    }
  }
}
