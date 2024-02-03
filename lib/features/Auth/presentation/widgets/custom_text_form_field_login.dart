import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        keyboardType: textInputType,
        validator: validator,
        onTap: onTap,
        readOnly: readOnly ?? false,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          // disabledBorder: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: hintText,
          hintStyle: AppStyles.styleSize14,
          fillColor: ColorsPalette.textFormFieldFillColor,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
