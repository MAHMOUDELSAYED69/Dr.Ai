import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../core/cache/cache.dart';
import '../../data/service/firebase/firebase_service.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitial());

  File? selectedImage;

  Future<void> pickImageFromGallery() async {
    emit(Imageloading());
    try {
      final returnImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      // selectedImage = File(returnImage!.path);
      if (returnImage != null) {
        await FirebaseService.updateUserImage(urlImage: returnImage.path);

        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({'image': returnImage.path}, SetOptions(merge: true));
        CacheData.setData(key: "uploadImage", value: returnImage.path);
        emit(ImageSuccess(imageUrl: returnImage.path));
      }
    } on Exception catch (err) {
      emit(ImageFailure(message: err.toString()));
    }
  }
}
