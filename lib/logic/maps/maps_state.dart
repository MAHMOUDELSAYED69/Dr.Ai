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

class MapsFailure extends MapsState {
  final String errMessage;

  MapsFailure({required this.errMessage});
}
