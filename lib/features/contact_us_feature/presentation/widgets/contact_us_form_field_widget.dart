import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/colors_palette.dart';

class ContactUsFormField extends StatelessWidget {
  final bool isRequired;
  final TextEditingController? textEditingController;
  final String hintText;
  final String? Function(String?)? validator;
  final int maxLine;
  final int minLine;

  const ContactUsFormField({
    super.key,
    this.isRequired = false,
    this.textEditingController,
    required this.hintText,
    this.validator,
    this.maxLine = 1,
    this.minLine = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLine,
      maxLines: maxLine,
      controller: textEditingController,
      decoration: InputDecoration(
        fillColor: ColorsPalette.userDrawerHeaderBackground,
        filled: true,
        hintText: hintText.tr(),
        suffixText: isRequired ? '*' : null,
        suffixStyle: isRequired
            ? const TextStyle(
                color: Colors.red,
                fontSize: 17,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }
}
