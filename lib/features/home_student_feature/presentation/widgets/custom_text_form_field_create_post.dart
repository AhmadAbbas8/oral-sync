import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../../../../core/utils/styles.dart';

class CustomTextFormFieldCreatePost extends StatelessWidget {
  const CustomTextFormFieldCreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFF9F9F9),
        hintText: LocaleKeys.describe_your_request_in_details.tr(),
        hintStyle: AppStyles.styleSize28.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      minLines: 6,
      maxLines: 8,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return LocaleKeys.required.tr();
        }
        return null;
      },
    );
  }
}
