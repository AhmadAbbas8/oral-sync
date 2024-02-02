import 'package:flutter/material.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/core/utils/styles.dart';

class CustomTextFormFieldLogin extends StatelessWidget {
  const CustomTextFormFieldLogin(
      {super.key,
      required this.width,
      required this.hintText,
      required this.prefixIcon,
      this.suffixIcon});

  final double width;

  final String hintText;

  final Widget prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
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
