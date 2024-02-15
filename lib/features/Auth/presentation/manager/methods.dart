import 'package:flutter/material.dart';
import 'package:oralsync/core/utils/size_helper.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_tow_form_field_widget.dart';

List<Widget> getFormFieldDoctorStudent(
    {required BuildContext context, bool? isDoc}) {
  var size = MediaQuery.sizeOf(context);
  if (isDoc == null) {
    return const [];
  } else if (!isDoc)
    return [
      SizeHelper.defSizedBoxField,
      const CustomTwoFormFieldWidget(fTitle: 'Academic Year', sTitle: 'GPA'),
      SizeHelper.defSizedBoxField,
      Padding(
        padding: EdgeInsets.only(
            left: size.width * .1, right: size.width * .1, bottom: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'University Address',
            style: AppStyles.styleSize14.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      const CustomTwoFormFieldWidget(fTitle: 'Government', sTitle: 'City'),
      SizeHelper.defSizedBoxField,
      const CustomTwoFormFieldWidget(fTitle: 'Street', sTitle: 'other'),
      SizeHelper.defSizedBoxField,
    ];
  else
    return [
      SizeHelper.defSizedBoxField,
      const CustomTwoFormFieldWidget(fTitle: 'Academic Year', sTitle: 'GPA'),
      SizeHelper.defSizedBoxField,
      Padding(
        padding: EdgeInsets.only(
            left: size.width * .1, right: size.width * .1, bottom: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Clinic Address',
            style: AppStyles.styleSize14.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      const CustomTwoFormFieldWidget(fTitle: 'Government', sTitle: 'City'),
      SizeHelper.defSizedBoxField,
      const CustomTwoFormFieldWidget(fTitle: 'Street', sTitle: 'Building'),
      SizeHelper.defSizedBoxField,
      const CustomTwoFormFieldWidget(fTitle: 'Floor', sTitle: 'Other'),
      SizeHelper.defSizedBoxField,
    ];
}

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
    return 'Email is required';
  } else if (!isEmail(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validatePassword(value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  } else if (!isStrongPassword(value)) {
    return 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one digit, and one special character';
  }
  return null;
}



String? generalValidator(value) {
  if (value!.isEmpty) {
    return 'required';
  }
  return null;
}