import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_ai/core/cache/cache.dart';
import 'package:dr_ai/data/model/user_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());
  final _firestore = FirebaseFirestore.instance;
  Future<void> getprofileData() async {
    emit(AccountLoading());
    try {
      _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((event) {
        UserDataModel userDataModel = UserDataModel.fromJson(event.data()!);
        CacheData.setData(key: "name", value: userDataModel.name);
        emit(AccountSuccess(userDataModel: userDataModel));
      });
    } on Exception catch (err) {
      emit(AccountFailure(message: err.toString()));
    }
  }

  Future<void> logout() async {
    emit(AccountLogoutLoading());
    try {
      await CacheData.clearData(clearData: true);
      await FirebaseAuth.instance.signOut();
      emit(AccountLogoutSuccess(message: "Logout successfully"));
    } on Exception catch (err) {
      emit(AccountFailure(message: err.toString()));
    }
  }

  Future<void> deleteAccount() async {
    emit(AccountDeleteLoading());
    try {
      // await FirebaseFirestore.instance
      //     .collection('chat_history')
      //     .doc(FirebaseAuth.instance.currentUser!.uid)
      //     .delete()
      //     .then((value) => log("DELETED CHAT HISTORY"));
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .delete();
      log("DELETED USER DATA");
      await CacheData.clearData(clearData: true);
      log("DELETED CACHE DATA");
      await FirebaseAuth.instance.currentUser!.delete();
      log("DELETED USER ACCOUNT");
      await FirebaseAuth.instance.signOut();
      log("LOGGED OUT");
      await Future.delayed(const Duration(seconds: 1));
      emit(AccountDeleteSuccess(
        message: "Account deleted successfully",
      ));
      log("ACCOUNT DELETED SUCCESSFULLY");
    } on Exception catch (err) {
      emit(AccountFailure(message: err.toString()));
    }
  }
  //? update user name

  Future<void> updateUserName({required String newName}) async {
    emit(ProfileUpdateLoading());
    try {
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'name': newName});
      emit(ProfileUpdateSuccess());
    } on Exception catch (err) {
      emit(ProfileUpdateFailure(message: err.toString()));
    }
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? dob,
    String? height,
    String? weight,
    String? chronicDiseases,
    String? familyHistoryOfChronicDiseases,
  }) async {
    emit(ProfileUpdateLoading());
    try {
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'name': name,
        'email': email,
        'phoneNumber': phone,
        'dob': dob,
        'height': height,
        'weight': weight,
        'chronicDiseases': chronicDiseases,
        'familyHistoryOfChronicDiseases': familyHistoryOfChronicDiseases
      });
      emit(ProfileUpdateSuccess());
    } on Exception catch (err) {
      emit(ProfileUpdateFailure(message: err.toString()));
    }
  }

  // //? update email
  // Future<void> updateEmail({required String newEmail}) async {
  //   emit(ProfileUpdateLoading());
  //   try {
  //     await FirebaseService.updateEmailWithReauth(newEmail: newEmail, password: );

  //     await _firestore
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.email)
  //         .update({'email': newEmail});

  //     emit(ProfileUpdateSuccess());
  //   } on Exception catch (err) {
  //     emit(ProfileUpdateFailure(message: err.toString()));
  //   }
  // }

  // //? update password
  // Future<void> updatePassword({required String newPassword}) async {
  //   emit(AccountLoading());
  //   try {
  //     await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
  //   } on Exception catch (err) {
  //     emit(AccountFailure(message: err.toString()));
  //   }
  // }

  // Future<void> loadPhoto() async {
  //   emit(AccountLoadingImage());
  //   try {
  //     String fileName = '${FirebaseAuth.instance.currentUser!.uid}.jpg';
  //     Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

  //     final url = await storageRef.getDownloadURL();
  //     await CacheData.setData(key: "image", value: url);

  //     emit(AccountLoadedImage(urlImage: url));
  //   } catch (err) {
  //     emit(AccountLoadedFailure(message: err.toString()));
  //     log('Error occurred while loading the image: $err');
  //     log(err.toString());
  //   }
  // }

  // Future<void> uploadUserPhoto() async {
  //   emit(AccountUpdateImageLoading());
  //   try {
  //     final returnImage =
  //         await ImagePicker().pickImage(source: ImageSource.camera);
  //     if (returnImage != null) {
  //       String fileName = '${FirebaseAuth.instance.currentUser!.uid}.jpg';
  //       // String fileName =
  //       //     '${FirebaseAuth.instance.currentUser!.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
  //       Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
  //       storageRef.putFile(File(returnImage.path));
  //       await loadPhoto();
  //       emit(AccountUpdateImageSuccess());
  //     } else {
  //       log("Image picking cancelled by user.");
  //       emit(AccountUpdateImageFailure(
  //           message: 'Image picking cancelled by user.'));
  //     }
  //   } catch (err) {
  //     log(err.toString());
  //     emit(AccountUpdateImageFailure(message: err.toString()));
  //   }
  // }
}
