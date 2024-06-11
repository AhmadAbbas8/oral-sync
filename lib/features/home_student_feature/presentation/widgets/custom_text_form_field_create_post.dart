import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../../../../core/utils/styles.dart';

class CustomTextFormFieldCreatePost extends StatelessWidget {
  const CustomTextFormFieldCreatePost({
    super.key,
    this.textEditingController,
    required this.caption,
  });

  final TextEditingController? textEditingController;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFF9F9F9),
        hintText: caption.tr(),
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
