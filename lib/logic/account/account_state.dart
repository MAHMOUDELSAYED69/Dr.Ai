part of 'account_cubit.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}
 //? user data
class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {
  final UserDataModel userDataModel;

  AccountSuccess({required this.userDataModel});
}

class AccountFailure extends AccountState {
  final String message;

  AccountFailure({required this.message});
}
//? Logout 
class AccountLogoutLoading extends AccountState {}

class AccountLogoutSuccess extends AccountState {
  final String message;

  AccountLogoutSuccess({required this.message});
}
//? Delete Account
class AccountDeleteLoading extends AccountState {}

class AccountDeleteSuccess extends AccountState {
  final String message;

  AccountDeleteSuccess({required this.message});
}
