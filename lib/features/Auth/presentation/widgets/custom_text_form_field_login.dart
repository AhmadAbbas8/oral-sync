import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/core/utils/styles.dart';

class CustomTextFormFieldLogin extends StatelessWidget {
  const CustomTextFormFieldLogin({
    super.key,
    required this.width,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.textInputType,
    this.validator,
    this.readOnly,
    this.onTap,
    this.textEditingController,
    this.inputFormatters,
  });

  final double width;
  final bool? obscureText;
  final bool? readOnly;

  final String hintText;
  final void Function()? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final TextEditingController? textEditingController;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        keyboardType: textInputType,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        onTap: onTap,
        readOnly: readOnly ?? false,
        obscureText: obscureText ?? false,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
            errorMaxLines: 3,
            hintText: hintText.tr(),
            hintStyle: AppStyles.styleSize14,
            fillColor: ColorsPalette.textFormFieldFillColor,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(25),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(25),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(25),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(25),
            )),
        controller: textEditingController,
      ),
    );
  }
}
