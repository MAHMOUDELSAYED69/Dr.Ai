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
        CacheData.setMapData(key: "userData", value: userDataModel.toJson());
        emit(AccountSuccess(userDataModel: userDataModel));
      });
    } on Exception catch (err) {
      emit(AccountFailure(message: err.toString()));
    }
  }

  Future<void> logout() async {
    emit(AccountLogoutLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      await CacheData.clearData(clearData: true);
      await FirebaseAuth.instance.signOut();
      emit(AccountLogoutSuccess(message: "Logout successfully"));
    } on Exception catch (err) {
      emit(AccountFailure(message: err.toString()));
    }
  }

  // Future<void> deleteUserData() async {
  //   try {
  //     if (FirebaseAuth.instance.currentUser != null) {
  //       final uid = FirebaseAuth.instance.currentUser!.uid;
  //       await FirebaseFirestore.instance
  //           .collection('chat_history')
  //           .doc(uid)
  //           .delete();
  //       log("DELETED CHAT HISTORY");
  //       await FirebaseFirestore.instance.collection('users').doc(uid).delete();
  //       log("DELETED USER DATA");
  //     } else {
  //       log("Data not deleted. User is not logged in.");
  //     }
  //   } catch (err) {
  //     log("Error deleting data: ${err.toString()}");
  //   }
  // }

  Future<void> deleteAccount() async {
    emit(AccountDeleteLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'isActive': false});
      await CacheData.clearData(clearData: true);
      log("DELETED CACHE DATA");
      await FirebaseAuth.instance.currentUser!.delete();
      log("DELETED USER ACCOUNT");
      await FirebaseAuth.instance.signOut();
      log("LOGGED OUT");
      emit(AccountDeleteSuccess(
        message: "Account deleted successfully",
      ));
      log("ACCOUNT DELETED SUCCESSFULLY");
    } on Exception catch (err) {
      emit(AccountFailure(message: err.toString()));
    }
  }
  //   Future<void> deleteAccount() async {
  //   emit(AccountDeleteLoading());
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       final uid = user.uid;
  //       final batch = FirebaseFirestore.instance.batch();
  //       batch.delete(
  //           FirebaseFirestore.instance.collection('chat_history').doc(uid));
  //       batch.delete(FirebaseFirestore.instance.collection('users').doc(uid));
  //       await batch
  //           .commit()
  //           .then((_) => log("DELETED CHAT HISTORY AND USER DATA"));

  //       await CacheData.clearData(clearData: true);
  //       log("DELETED CACHE DATA");

  //       await user.delete();
  //       log("DELETED USER ACCOUNT");

  //       await FirebaseAuth.instance.signOut();
  //       log("LOGGED OUT");

  //       emit(AccountDeleteSuccess(message: "Account deleted successfully"));
  //       log("ACCOUNT DELETED SUCCESSFULLY");
  //     }
  //   } catch (err) {
  //     emit(AccountFailure(message: err.toString()));
  //     log("ERROR: ${err.toString()}");
  //   }
  // }

  //? update user name

  Future<void> updateUserName({required String newName}) async {
    emit(ProfileUpdateLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 400));
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
    String? phoneNumber,
    String? dob,
    String? height,
    String? weight,
    String? chronicDiseases,
    String? familyHistoryOfChronicDiseases,
  }) async {
    emit(ProfileUpdateLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 400));
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
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

  Future<void> reAuthenticateUser(String password) async {
    emit(AccountReAuthLoading());
    await Future.delayed(const Duration(milliseconds: 400));
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    if (user != null) {
      AuthCredential credential = EmailAuthProvider.credential(
          email: (user.email).toString(), password: password);
      try {
        await user.reauthenticateWithCredential(credential);
        emit(AccountReAuthSuccess());
        log('User re-authenticated successfully');
      } on FirebaseAuthException catch (err) {
        emit(AccountReAuthFailure(message: err.message.toString()));
        log('Re-authentication failed: ${err.message}');
      }
    } else {
      log('No user found. Please sign in first.');
    }
  }

  Future<void> updatePassword(String newPassword) async {
    emit(AccountUpdatePasswordLoading());
    await Future.delayed(const Duration(milliseconds: 400));
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    if (user != null) {
      try {
        await user.updatePassword(newPassword);
        emit(AccountUpdatePasswordSuccess(
            message: 'Password updated successfully'));
        log('Password updated successfully');
      } on FirebaseAuthException catch (err) {
        emit(AccountUpdatePasswordFailure(message: err.message.toString()));
        log('Password update failed: ${err.message}');
      }
    } else {
      log('No user found. Please sign in first.');
    }
  }

  Future<void> storeUserRating(double rating) async {
    AccountRatingLoading();
    try {
      await Future.delayed(const Duration(milliseconds: 400));
      DocumentReference userDocRef = _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);

      await userDocRef.set({
        'rating': rating,
      }, SetOptions(merge: true));
      emit(AccountRatingSuccess(
        thxMessage: "Thanks for rating us",
      ));
      log('User rating updated successfully.');
    } on FirebaseException catch (err) {
      emit(AccountRatingFailure(message: err.message.toString()));
      log('Error updating user rating: $err');
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
