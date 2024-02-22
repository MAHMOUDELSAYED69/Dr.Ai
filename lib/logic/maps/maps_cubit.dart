import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dr_ai/data/model/place_suggetion.dart';
import 'package:dr_ai/data/service/api/place_suggetion.dart';
import 'package:meta/meta.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  MapsCubit() : super(MapsInitial());

  Future<void> getPlaceSuggetions(
      {required String place, required String sessionToken}) async {
    emit(MapsLoading());
    try {
      dynamic response =
          await PlacesWebservices.fetchSuggestions(place, sessionToken);

      List<dynamic> predictions = response;
      List<PlaceSuggestionModel> suggestionList = predictions
          .map((prediction) => PlaceSuggestionModel.fromJson(prediction))
          .toList();

      emit(MapsLoadedSuccess(placeSuggestionList: suggestionList));
      
    } on DioException catch (err) {
      emit(MapsFailure(errMessage: err.toString()));
      log("Dio err:$err");
    } catch (err) {
      emit(MapsFailure(errMessage: err.toString()));
      log(err.toString());
    }
  }
}
