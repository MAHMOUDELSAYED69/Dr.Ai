import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../core/cache/cache.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitial());
  CollectionReference fireStore =
      FirebaseFirestore.instance.collection('image');
  File? selectedImage;
  Future pickImageFromGallery() async {
    emit(Imageloading());
    try {
      final returnImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      selectedImage = File(returnImage!.path);
      CacheData.setData(key: "uploadImage", value: returnImage.path);
      emit(ImageSuccess(imageUrl: returnImage.path));
    } on Exception catch (err) {
      emit(ImageFailure(message: err.toString()));
    }
  }
}
