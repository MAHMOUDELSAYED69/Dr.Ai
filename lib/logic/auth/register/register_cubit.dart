import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dr_ai/data/service/firebase/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> userVerifyEmail() async {
    emit(RegisterLoading());
    try {
      await FirebaseService.emailVerify();
      emit(VerifyEmailSuccess());
    } on FirebaseAuthException catch (err) {
      emit(RegisterFailure(message: err.code));
    }
  }

  Future<void> userRegister({
    required String email,
    required String password,
    required String displayName,
  }) async {
    emit(RegisterLoading());
    try {
      await FirebaseService.register(
          email: email, password: password, displayName: displayName);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (err) {
      emit(RegisterFailure(message: err.code));
    } catch (err) {
      log(err.toString());
    }
  }
}
