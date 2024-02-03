import 'package:flutter/material.dart';
import 'package:oralsync/core/utils/colors_palette.dart';

class CustomLoginButtonWidget extends StatelessWidget {
  const CustomLoginButtonWidget(
      {super.key, required this.title, this.onPressed, required this.minWidth});

  final String title;

  final void Function()? onPressed;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
      // clipBehavior: Clip.hardEdge,
      color: ColorsPalette.buttonLoginColor,
      minWidth: minWidth,
      height: 50,
      textColor: Colors.white,
      onPressed: onPressed,
      child:  Text(title),
    );
  }
}
