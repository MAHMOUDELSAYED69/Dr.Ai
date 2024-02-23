import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dr_ai/data/model/place_location.dart';
import 'package:dr_ai/data/model/place_suggetion.dart';
import 'package:dr_ai/data/service/api/maps_place.dart';
import 'package:meta/meta.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  MapsCubit() : super(MapsInitial());

  //! Place suggetions.
  Future<void> getPlaceSuggetions(
      {required String place, required String sessionToken}) async {
    emit(MapsLoading());
    try {
      List<dynamic> response =
          await PlacesWebservices.fetchPlaceSuggestions(place, sessionToken);

      List<PlaceSuggestionModel> suggestionList = response
          .map((prediction) => PlaceSuggestionModel.fromJson(prediction))
          .toList();

      //! JUST FOR TESTING
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
      {required String placeId, required String sessionToken}) async {
    emit(MapsLoading());
    try {
      var response =
          await PlacesWebservices.fetchPlaceLocation(placeId, sessionToken);
      log(response.toString());
      PlaceLocationModel placeLocationModel =
          PlaceLocationModel.fromJson(response);

      emit(MapsLoadedLocationSuccess(placeLocationModel: placeLocationModel));
    } on DioException catch (err) {
      emit(MapsFailure(errMessage: err.toString()));
      log("Dio err: $err");
    } catch (err) {
      emit(MapsFailure(errMessage: err.toString()));
      log(err.toString());
    }
  }
}
