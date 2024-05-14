import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show TextDirection;
import 'package:meta/meta.dart';
import 'package:intl/intl.dart ' hide TextDirection;
part 'formvalidation_state.dart';

class FormvalidationCubit extends Cubit<FormvalidationState> {
  FormvalidationCubit() : super(FormvalidationInitial());
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  TextDirection? getTextDirection(String text) {
    bool isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(text);
    return isArabic ? TextDirection.rtl : TextDirection.ltr;
  }

  String? validatePassword(String? value, [String? firebaseException]) {
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
    // if (firebaseException != null ||
    //     firebaseException != '' ||
    //     firebaseException?.isNotEmpty == true) {
    //   return validateFirebaseException(firebaseException);
    // }
    _password = value;

    emit(PasswordValidationSuccess());
    return null;
  }

  bool _hasUpperCase(String value) => value.contains(RegExp(r'[A-Z]'));
  bool _hasLowerCase(String value) => value.contains(RegExp(r'[a-z]'));
  bool _hasDigit(String value) => value.contains(RegExp(r'\d'));

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _password) {
      return 'Passwords do not match';
    }
    _confirmPassword = value;

    emit(ConfirmPasswordValidationSuccess());
    return null;
  }

  String? validateEmail(String? value, [String? firebaseException]) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    if (!_hasValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    _email = value;
    // if (firebaseException != null ||
    //     firebaseException != '' ||
    //     firebaseException?.isNotEmpty == true) {
    //   return validateFirebaseException(firebaseException);
    // }
    emit(EmailValidationSuccess());
    return null;
  }

  bool _hasValidEmail(String email) {
    final RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&\'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    if (!RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$")
        .hasMatch(value)) {
      return 'Please enter a valid name';
    }
    return null;
  }

  String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }

    if (!RegExp(r"^\+?\d{10,12}$").hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? heightValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Height cannot be empty';
    }
    if (!RegExp(r"^\d+(\.\d+)?$").hasMatch(value)) {
      return 'Please enter a valid height in CM';
    }
    return null;
  }

  String? weightValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Weight cannot be empty';
    }
    if (!RegExp(r"^\d+(\.\d+)?$").hasMatch(value)) {
      return 'Please enter a valid weight in KG';
    }
    return null;
  }

  String? validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date of birth cannot be empty';
    }

    final dateFormat = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!dateFormat.hasMatch(value)) {
      return 'Enter date of birth in the format DD/MM/YYYY';
    }

    try {
      final date = DateFormat('dd/MM/yyyy').parseStrict(value);
      final today = DateTime.now();

      if (date.isAfter(today)) {
        return 'Date of birth cannot be in the future';
      }

      final age = today.year - date.year;
      if (date.month > today.month ||
          (date.month == today.month && date.day > today.day)) {
        if (age - 1 < 18) {
          return 'You must be at least 18 years old';
        }
      } else {
        if (age < 18) {
          return 'You must be at least 18 years old';
        }
      }
    } catch (e) {
      return 'Invalid date of birth';
    }

    return null;
  }

  String? validateDay(String? value) {
    if (value == null || value.isEmpty) {
      return 'Day cannot be empty';
    }

    final dayFormat = RegExp(r'^\d{2}$');
    if (!dayFormat.hasMatch(value)) {
      return 'Enter a valid day (DD)';
    }

    final day = int.tryParse(value);
    if (day == null || day < 1 || day > 31) {
      return 'Invalid day';
    }

    return null;
  }

  String? validateMonth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Month cannot be empty';
    }

    final monthFormat = RegExp(r'^\d{2}$');
    if (!monthFormat.hasMatch(value)) {
      return 'Enter a valid month (MM)';
    }

    final month = int.tryParse(value);
    if (month == null || month < 1 || month > 12) {
      return 'Invalid month';
    }

    return null;
  }

  String? validateYear(String? value) {
    if (value == null || value.isEmpty) {
      return 'Year cannot be empty';
    }

    final yearFormat = RegExp(r'^\d{4}$');
    if (!yearFormat.hasMatch(value)) {
      return 'Enter a valid year (YYYY)';
    }

    final year = int.tryParse(value);
    if (year == null || year < 1900 || year > DateTime.now().year) {
      return 'Invalid year';
    }

    return null;
  }

  String? validateFirebaseException(String? value) {
    if (value != null) {
      switch (value) {
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'user-disabled':
          return 'The user account has been disabled by an administrator.';
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'Wrong password provided for that user.';
        case 'account-exists-with-different-credential':
          return 'An account already exists with the same email address but different sign-in credentials.';
        case 'email-already-in-use':
          return 'The email address is already in use by another account.';
        case 'operation-not-allowed':
          return 'Email/password accounts are not enabled.';
        case 'requires-recent-login':
          return 'This operation is sensitive and requires recent authentication. Log in again before retrying this request.';
        case 'invalid-credential':
          return 'The provided credential is not valid.';
        case 'invalid-verification-code':
          return 'The verification code is invalid.';
        case 'invalid-verification-id':
          return 'The verification ID is invalid.';
        case 'user-mismatch':
          return 'The provided credentials do not correspond to the previously signed in user.';
        case 'weak-password':
          return 'The password must be 6 characters long or more.';
        case 'network-request-failed':
          return 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.';
        case 'too-many-requests':
          return 'Too many requests. Try again later.\n بطل سبام ياعرص';
        default:
          return value;
      }
    }
    return null;
  }
}
