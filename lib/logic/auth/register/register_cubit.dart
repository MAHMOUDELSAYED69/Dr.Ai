import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  CollectionReference fireStore = FirebaseFirestore.instance.collection('names');
  Future<void> userRegister(
      {required String email,
      required String password,
      required String fullName}) async {
    emit(RegisterLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      fireStore.add({"email": email, "name": fullName});

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (err) {
      emit(RegisterFailure(message: err.code));
    } catch (err) {
      log(err.toString());
    }
  }
}

/* 
 *Future<void> signUpWithEmailAndPassword(
      String email, String password, String fullName) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // After creating the user, update the display name (full name)
      User? user = userCredential.user;
      if (user != null) {
        UserUpdateInfo updateInfo = UserUpdateInfo();
        updateInfo.displayName = fullName;

        await user.updateProfile(updateInfo);
        await user.reload(); // Reload the user for the updated information

        print("User registered successfully with display name: ${user.displayName}");
      }
    } catch (e) {
      print("Error signing up: $e");
    }
  } 
 * 
 */