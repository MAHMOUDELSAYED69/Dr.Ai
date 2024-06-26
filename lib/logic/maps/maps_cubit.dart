import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dr_ai/data/model/place_directions.dart';
import 'package:dr_ai/data/model/place_location.dart';
import 'package:dr_ai/data/model/place_suggetion.dart';
import 'package:dr_ai/data/service/api/maps_place.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../core/cache/cache.dart';
import '../../data/model/find_hospital_place_info.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  MapsCubit() : super(MapsInitial());

  double? lat;
  double? lng;
  Position? _position;
  //! Place suggetions.
  Future<void> getPlaceSuggetions({
    required String place,
    required String sessionToken,
  }) async {
    emit(MapsLoading());
    try {
      _position = await Geolocator.getCurrentPosition();
      List<dynamic> response = await PlacesWebservices.fetchPlaceSuggestions(
          place.trim(), sessionToken,
          latitude: _position!.latitude, longitude: _position!.longitude);

      List<PlaceSuggestionModel> suggestionList = response
          .map((prediction) => PlaceSuggestionModel.fromJson(prediction))
          .toList();

      // //! JUST FOR TESTING
      int index = suggestionList.length - 1;
      while (index > 0) {
        log(suggestionList[index].placeId);
        index--;
      }

      emit(MapsLoadedSuggestionsSuccess(placeSuggestionList: suggestionList));
    } on DioException catch (err) {
      emit(MapsFailure(errMessage: err.toString()));
      log("Dio err:$err");
    } catch (err) {
      emit(MapsFailure(errMessage: err.toString()));
      log(err.toString());
    }
  }

  //! Place Location.
  Future<void> getPlaceLocation(
      {required String placeId,
      required String sessionToken,
      String? description}) async {
    emit(MapsLoading());
    try {
      var response = await PlacesWebservices.fetchPlaceLocation(
          placeId.trim(), sessionToken);
      PlaceLocationModel placeLocationModel =
          PlaceLocationModel.fromJson(response);
      log(placeLocationModel.toString());
      emit(MapsLoadedLocationSuccess(
          placeLocation: [placeLocationModel, description]));
    } on DioException catch (err) {
      emit(MapsFailure(errMessage: err.toString()));
      log("Dio err: $err");
    } catch (err) {
      emit(MapsFailure(errMessage: err.toString()));
      log(err.toString());
    }
  }

  Future<void> getPlaceDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    emit(MapsLoading());
    try {
      var response =
          await PlacesWebservices.getPlaceDirections(origin, destination);

      final directions = PlaceDirectionsModel.fromJson(response);
      log(destination.toString());

      emit(MapsLoadedDirectionsSuccess(placeDirections: directions));
    } on DioException catch (err) {
      emit(MapsFailure(errMessage: err.toString()));
      log("Dio err: $err");
    } catch (err) {
      emit(MapsFailure(errMessage: err.toString()));
      log(err.toString());
    }
  }

  Future<void> getNearestHospitals({double? radius}) async {
    try {
      emit(FindHospitalLoading());
      _position ??= await Geolocator.getCurrentPosition();
      log('Loading nearest hospitals...');

      final List<FindHospitalsPlaceInfo> hospitalsData =
          await FindHospitalWebService.getNearestHospital(
              _position!.latitude, _position!.longitude, 500);

      final List<Map<String, dynamic>> hospitalsCacheData =
          hospitalsData.map((hospital) {
        return {
          'name': hospital.name,
          'openNow': hospital.openNow,
          'rate': hospital.rating,
          'userRatingsTotal': hospital.userRatingsTotal,
          'lat': hospital.lat,
          'lng': hospital.lng,
          'businessStatus': hospital.businessStatus,
          'placeId': hospital.placeId,
          'formattedPhoneNumber': hospital.formattedPhoneNumber,
          'internationalPhoneNumber': hospital.internationalPhoneNumber,
          'photos': hospital.photos,
          'distance': hospital.distance,
          'duration': hospital.duration,
        };
      }).toList();

      await CacheData.setLastUpdatedTime('LastUpdated');
      await CacheData.setListOfMaps(
          key: 'nearestHospitals', value: hospitalsCacheData);
      log('Success: Cached nearest hospitals data.');

      if (hospitalsData.isEmpty) {
        emit(FindHospitalFailure(message: 'No hospitals found.'));
      } else {
        emit(FindHospitalSuccess(hospitalsList: hospitalsData));
        log('Success: Loaded nearest hospitals.');
      }
      await CacheData.setData(key: 'selectedValue', value: 500);
    } catch (err) {
      log('Error: $err');
      emit(FindHospitalFailure(message: err.toString()));
    }
  }
}
