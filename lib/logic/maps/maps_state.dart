part of 'maps_cubit.dart';

@immutable
abstract class MapsState {}

class MapsInitial extends MapsState {}

class MapsLoading extends MapsState {}

class MapsLoadedSuccess extends MapsState {
  final List<PlaceSuggestionModel> placeSuggestionList;

  MapsLoadedSuccess({required this.placeSuggestionList});
}

class MapsFailure extends MapsState {
  final String errMessage;
  MapsFailure({required this.errMessage});
}
