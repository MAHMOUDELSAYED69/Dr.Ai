part of 'sign_in_cubit.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class EmailNotVerified extends SignInState {
  EmailNotVerified({required this.message});
  final String message;
}

class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {
  SignInFailure({required this.message});
  final String message;
}
