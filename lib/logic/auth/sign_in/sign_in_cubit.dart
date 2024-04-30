import 'package:bloc/bloc.dart';
import 'package:dr_ai/data/service/firebase/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  String? _validateFirebaseException(String? value) {
    if (value != null) {
      switch (value) {
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'user-disabled':
          return 'The user account has been disabled by an administrator.';
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'Wrong password provided for that user.';
        case 'account-exists-with-different-credential':
          return 'An account already exists with the same email address but different sign-in credentials.';
        case 'email-already-in-use':
          return 'The email address is already in use by another account.';
        case 'operation-not-allowed':
          return 'Login with email and password is Disabled by an administrator.';
        case 'requires-recent-login':
          return 'This operation is sensitive and requires recent authentication. Log in again before retrying this request.';
        case 'invalid-credential':
          return 'The provided Email or Password is not valid.';
        case 'invalid-verification-code':
          return 'The verification code is invalid.';
        case 'invalid-verification-id':
          return 'The verification ID is invalid.';
        case 'user-mismatch':
          return 'The provided credentials do not correspond to the previously signed in user.';
        case 'weak-password':
          return 'The password must be 6 characters long or more.';
        case 'network-request-failed':
          return 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.';
        case 'too-many-requests':
          return 'Too many requests. Try again later.';
        default:
          return value;
      }
    }
    return null;
  }

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
        emit(EmailNotVerified(
            message:
                "Email not verified, check your email for verification link"));
      }
    } on FirebaseAuthException catch (err) {
      final errMessage = _validateFirebaseException(err.code);
      emit(SignInFailure(message: errMessage ?? err.code));
    } catch (err) {
      emit(SignInFailure(message: err.toString()));
    }
  }
}
