part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}
 
class RegisterInitial extends RegisterState {}
class RegisterLoading extends RegisterState {}
class VerifyEmailSuccess extends RegisterState {}
class RegisterSuccess extends RegisterState {}
class RegisterFailure extends RegisterState {
  final String message;
  RegisterFailure({required this.message});
}


