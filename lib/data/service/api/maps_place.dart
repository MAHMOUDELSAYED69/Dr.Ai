import 'package:dio/dio.dart';
import 'package:dr_ai/utils/constant/api_url.dart';
import 'dart:developer';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../model/find_hospital_place_info.dart';

class PlacesWebservices {
  static Dio dio = Dio();

  // static Future<void> fetchNearestHospitals(
  //     double latitude, double longitude) async {
  //   final Map<String, dynamic> queryParameters = {
  //     'location': '$latitude,$longitude',
  //     'radius': '5000',
  //     'type': 'hospital',
  //     'key': ApiUrlManager.googleMap,
  //   };

  //   try {
  //     final response =
  //         await _dio.get(, queryParameters: queryParameters);
  //     if (response.statusCode == 200) {
  //       print('Hospitals data: ${response.data}');
  //       // Handle the received data
  //     } else {
  //       print('Error fetching hospitals: ${response.statusMessage}');
  //     }
  //   } catch (e) {
  //     print('Exception caught: $e');
  //   }
  // }

  //! Fetch Suggetions.
  static Future fetchPlaceSuggestions(String place, String sessionToken,
      {double? latitude, double? longitude}) async {
    try {
      Response response = await dio.get(
        ApiUrlManager.placeSuggetion,
        queryParameters: {
          'location': '$latitude,$longitude',
          'radius': 5000,
          'input': place,
          'region': 'eg',
          'keyword': 'cruise',
          'types': 'hospital',
          'components': 'country:eg',
          'key': ApiUrlManager.googleMapApiKey,
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
        ApiUrlManager.placeLocation,
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry',
          'key': ApiUrlManager.googleMapApiKey,
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
        ApiUrlManager.directions,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': ApiUrlManager.googleMapApiKey,
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

  static Future getNearestHospital(
      double latitude, double longitude, String sessionToken) async {
    final queryParameters = {
      'location': '$latitude,$longitude',
      'radius': '5000',
      'types': 'hospital',
      'key': ApiUrlManager.googleMapApiKey,
      'sessiontoken': sessionToken,
    };

    try {
      final response = await dio.get(ApiUrlManager.nearestHospital,
          queryParameters: queryParameters);
      // log("Nearby hospitals data are here: ${response.data}");

      for (int i = 0; i < response.data['results'].length; i++) {
        log(response.data['results'][i]['name']);
      }
    } catch (err) {
      log(err.toString());
    }
  }
}

class FindHospitalWebService {
  static final Dio dio = Dio();

  static Future<List<FindHospitalsPlaceInfo>> getNearestHospital(
      double latitude, double longitude, double? radius) async {
    List<FindHospitalsPlaceInfo> hospitals = [];

    log('call getNearestHospital');
    try {
      final response = await dio.get(
        ApiUrlManager.nearestHospital,
        queryParameters: {
          'location': '$latitude,$longitude',
          'radius': radius?.toString() ?? '5000',
          'types': ['hospital', 'emergency_hospital', 'surgery_hospital'],
          'key': ApiUrlManager.googleMapApiKey,
        },
      );

      if (response.data == null || response.data['results'] == null) {
        log('Response data is null or missing results key');
        return hospitals;
      }

      final List<dynamic> results = response.data['results'];
      for (var item in results) {
        hospitals.add(FindHospitalsPlaceInfo.fromJson(item));
      }
    } catch (err) {
      log('Error: $err');
      return hospitals;
    }

    return hospitals;
  }
}
