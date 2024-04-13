part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

//? verify email
class VerifyEmailSuccess extends SignUpState {}

class VerifyEmailFailure extends SignUpState {
  final String errorMessage;
  VerifyEmailFailure({required this.errorMessage});
}

//? create password
class CreatePasswordSuccess extends SignUpState {}

class CreatePasswordFailure extends SignUpState {
  final String errorMessage;
  CreatePasswordFailure({required this.errorMessage});
}

//? create profile
class CreateProfileSuccess extends SignUpState {}

class CreateProfileFailure extends SignUpState {
  final String errorMessage;
  CreateProfileFailure({required this.errorMessage});
}
