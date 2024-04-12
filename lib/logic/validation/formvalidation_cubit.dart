import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
part 'formvalidation_state.dart';

class FormvalidationCubit extends Cubit<FormvalidationState> {
  FormvalidationCubit() : super(FormvalidationInitial());
  String email = '';
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

  bool _hasUpperCase(String value) => value.contains(RegExp(r'[A-Z]'));
  bool _hasLowerCase(String value) => value.contains(RegExp(r'[a-z]'));
  bool _hasDigit(String value) => value.contains(RegExp(r'\d'));

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    confirmPassword = value;
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
    email = value;
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
}
