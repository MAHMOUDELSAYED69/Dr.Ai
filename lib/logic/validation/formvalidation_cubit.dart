import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'formvalidation_state.dart';

class FormvalidationCubit extends Cubit<FormvalidationState> {
  FormvalidationCubit() : super(FormvalidationInitial());
  String password = '';
  String confirmPassword = '';
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!_hasUpperCase(value)) {
      return 'Password must have at least one uppercase character';
    }
    if (!_hasLowerCase(value)) {
      return 'Password must have at least one lowercase character';
    }
    if (!_hasDigit(value)) {
      return 'Password must have at least one number';
    }
    password = value;
    emit(PasswordValidationSuccess());
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    emit(ConfirmPasswordValidationSuccess());
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    if (!_hasValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  bool _hasUpperCase(String value) => value.contains(RegExp(r'[A-Z]'));
  bool _hasLowerCase(String value) => value.contains(RegExp(r'[a-z]'));
  bool _hasDigit(String value) => value.contains(RegExp(r'\d'));
  bool _hasValidEmail(String email) {
    final RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&\'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }
}
