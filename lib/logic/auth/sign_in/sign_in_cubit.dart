import 'package:bloc/bloc.dart';
import 'package:dr_ai/data/service/firebase/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  Future<void> userSignIn(
      {required String email, required String password}) async {
    emit(SignInLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.emailVerified == true) {
        emit(SignInSuccess());
      } else if (userCredential.user!.emailVerified == false) {
        await FirebaseService.emailVerify();
        emit(SignInNotVerified(
            message:
                "Email not verified, check your email for verification link"));
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == "too-many-requests") {
        emit(SignInFailure(message: dotenv.env["spamMessage"]!));
      } else {
        emit(SignInFailure(message: err.message ?? err.code));
      }
    } catch (err) {
      emit(SignInFailure(message: err.toString()));
    }
  }
}
