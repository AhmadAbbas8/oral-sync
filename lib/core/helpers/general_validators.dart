import 'package:easy_localization/easy_localization.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

bool isStrongPassword(String password) {
  // Check length
  if (password.length < 8) {
    return false;
  }

  // Check for uppercase letter
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return false;
  }

  // Check for lowercase letter
  if (!password.contains(RegExp(r'[a-z]'))) {
    return false;
  }

  // Check for digit
  if (!password.contains(RegExp(r'[0-9]'))) {
    return false;
  }

  // Check for special character
  if (!password.contains(RegExp(r'[!@#$%^&*]'))) {
    return false;
  }

  return true;
}

bool isEmail(String email) {
  // Regular expression for validating email addresses
  final RegExp emailRegex =
  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return emailRegex.hasMatch(email);
}

String? validateEmail(value) {
  if (value == null || value.isEmpty) {
    return LocaleKeys.email_is_required.tr();
  } else if (!isEmail(value)) {
    return LocaleKeys.please_enter_a_valid_email_address.tr();
  }
  return null;
}

String? validatePassword(value) {
  if (value == null || value.isEmpty) {
    return LocaleKeys.password_is_required.tr();
  } else if (!isStrongPassword(value)) {
    return LocaleKeys.strength_password_message.tr();
  }
  return null;
}

String? generalValidator(value) {
  if (value!.isEmpty) {
    return LocaleKeys.required.tr();
  }
  return null;
}
