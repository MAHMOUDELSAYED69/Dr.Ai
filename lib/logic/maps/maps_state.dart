part of 'maps_cubit.dart';

@immutable
abstract class MapsState {}

class MapsInitial extends MapsState {}

class MapsLoading extends MapsState {}

class MapsLoadedSuggestionsSuccess extends MapsState {
  final List<PlaceSuggestionModel> placeSuggestionList;

  MapsLoadedSuggestionsSuccess({required this.placeSuggestionList});
}

class MapsLoadedLocationSuccess extends MapsState {
  final List<dynamic> placeLocation;

  MapsLoadedLocationSuccess({required this.placeLocation});
}

class MapsLoadedDirectionsSuccess extends MapsState {
  final dynamic placeDirections;

  MapsLoadedDirectionsSuccess({required this.placeDirections});
}

class MapsFailure extends MapsState {
  final String errMessage;

  MapsFailure({required this.errMessage});
}

class FindHospitalInitial extends MapsState {}

class FindHospitalLoading extends MapsState {}

class FindHospitalSuccess extends MapsState {
  final List<FindHospitalsPlaceInfo?> hospitalsList;

  FindHospitalSuccess({required this.hospitalsList});
}

class FindHospitalFailure extends MapsState {
  final String message;
  FindHospitalFailure({required this.message});
}
