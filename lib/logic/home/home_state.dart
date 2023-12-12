part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final String firebaseName;
  final String image;
  final String cacheImage;
  HomeSuccess(
      {required this.cacheImage,
      required this.firebaseName,
      required this.image});
}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure({required this.message});
}
