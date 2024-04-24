import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../utils/colors_palette.dart';

Future<void> showCustomSnackBar(
  BuildContext context, {
  required String msg,
  Color? backgroundColor,
}) async {
  showTopSnackBar(
    Overlay.of(context),
    backgroundColor == ColorsPalette.errorColor
        ? CustomSnackBar.error(
            boxShadow: const [],
            backgroundColor: ColorsPalette.errorColor,
            message: msg,
          )
        : CustomSnackBar.success(
            boxShadow: const [],
            backgroundColor: backgroundColor ?? Colors.black,
            message: msg,
          ),
  );

  // ScaffoldMessenger.of(context).removeCurrentSnackBar();
  //
  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //     content: Text(
  //       msg,
  //       style: const TextStyle(color: Colors.white),
  //     ),
  //     behavior: SnackBarBehavior.floating,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //     duration: const Duration(seconds: 5),
  //     backgroundColor: backgroundColor ?? Colors.black,
  //   ),
  // );
}
