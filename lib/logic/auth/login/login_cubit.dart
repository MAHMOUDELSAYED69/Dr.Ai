import 'package:bloc/bloc.dart';
import 'package:dr_ai/data/service/firebase/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> userLogin(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await FirebaseService.logIn(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (err) {
      emit(LoginFailure(message: err.code));
    } catch (err) {
      emit(LoginFailure(message: err.toString()));
    }
  }
}
