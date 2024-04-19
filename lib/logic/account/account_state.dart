part of 'account_cubit.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {}

class AccountFailure extends AccountState {
  final String message;

  AccountFailure({required this.message});
}
