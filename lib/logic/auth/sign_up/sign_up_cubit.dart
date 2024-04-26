import 'package:bloc/bloc.dart';
import 'package:dr_ai/data/service/firebase/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  String email = '';
  String password = '';
  Future<void> verifyEmail() async {
    emit(SignUpLoading());
    try {
      await FirebaseService.emailVerify();
      emit(VerifyEmailSuccess());
    } on Exception catch (err) {
      emit(VerifyEmailFailure(errorMessage: err.toString()));
    }
  }

  Future<void> createPassword() async {
    emit(SignUpLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(CreatePasswordSuccess());
    } on Exception catch (err) {
      emit(CreateProfileFailure(errorMessage: err.toString()));
    }
  }

  Future<void> createProfile(
      {required String name,
      required String phoneNumber,
      required String dob,
      required String gender,
      required String bloodType,
      required String height,
      required String weight,
      required String chronicDiseases,
      required String familyHistoryOfChronicDiseases}) async {
    emit(SignUpLoading());
    try {
      await FirebaseService.storeUserData(
          name: name,
          phoneNumber: phoneNumber,
          dob: dob,
          gender: gender,
          bloodType: bloodType,
          height: height,
          weight: weight,
          chronicDiseases: chronicDiseases,
          familyHistoryOfChronicDiseases: familyHistoryOfChronicDiseases);
      emit(CreateProfileSuccess());
    } on Exception catch (err) {
      emit(CreateProfileFailure(errorMessage: err.toString()));
    }
  }
}
