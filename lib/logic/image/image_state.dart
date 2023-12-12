part of 'image_cubit.dart';

@immutable
abstract class ImageState {}

class ImageInitial extends ImageState {}

class Imageloading extends ImageState {}

class ImageSuccess extends ImageState {
  final String imageUrl;

  ImageSuccess({required this.imageUrl});
}

class ImageFailure extends ImageState {
  final String message;

  ImageFailure({required this.message});
}


