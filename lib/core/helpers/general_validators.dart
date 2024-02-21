import 'package:easy_localization/easy_localization.dart';
import 'package:oralsync/core/helpers/reg_ex.dart';
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
bool isPhoneValid(String phone) {
  // Regular expression for validating email addresses
  final RegExp emailRegex =
  RegExp(CustomRegEx.phoneNumberRegExEgypt);
  return emailRegex.hasMatch(phone);
}

String? validateEmail(value) {
  if (value == null || value.isEmpty) {
    return LocaleKeys.email_is_required.tr();
  } else if (!isEmail(value)) {
    return LocaleKeys.please_enter_a_valid_email_address.tr();
  }
  return null;
}
String? validatePhoneNumber(value) {
  if (value == null || value.isEmpty) {
    return LocaleKeys.required.tr();
  } else if (!isPhoneValid(value)) {
    return LocaleKeys.invalid_phone_number.tr();
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

String? gpaValidator(value) {
  var doubleNum = double.tryParse(value) ?? 0;
  if (value!.isEmpty) {
    return LocaleKeys.required.tr();
  } else if (doubleNum > 5.0 || doubleNum < 2.0) {
    return LocaleKeys.gpa_must_between_2_and_5.tr();
  }
  return null;
}
String? academicValidator(value) {
  var intNum = int.tryParse(value) ?? 0;
  if (value!.isEmpty) {
    return LocaleKeys.required.tr();
    //2020 , 2030
  } else if (intNum > DateTime.now().year+5 || intNum < DateTime.now().year-5) {
    return LocaleKeys.invalid_range.tr();
  }
  return null;
}
