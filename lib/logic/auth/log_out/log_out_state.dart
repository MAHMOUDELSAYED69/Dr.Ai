part of 'log_out_cubit.dart';

@immutable
abstract class LogOutState {}

class LogOutInitial extends LogOutState {}

class LogOutLoading extends LogOutState {}

class LogOutSuccess extends LogOutState {

}

class LogOutFailure extends LogOutState {
  final String message;

  LogOutFailure({required this.message});
}
