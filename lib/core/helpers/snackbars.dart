
import 'package:flutter/material.dart';

Future<void> showCustomSnackBar(BuildContext context,
    {required String msg, Color? backgroundColor}) async {

  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      duration: const Duration(seconds: 5),
      backgroundColor: backgroundColor ?? Colors.black,
    ),
  );
}
