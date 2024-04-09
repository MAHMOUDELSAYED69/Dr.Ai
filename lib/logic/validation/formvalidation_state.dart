part of 'formvalidation_cubit.dart';

@immutable
abstract class FormvalidationState {}

class FormvalidationInitial extends FormvalidationState {}

class EmailValidationSuccess extends FormvalidationState {}

class PasswordValidationSuccess extends FormvalidationState {}

class ConfirmPasswordValidationSuccess extends FormvalidationState {}
