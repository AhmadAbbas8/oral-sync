import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showCustomSnackBar(BuildContext context,
    {required String msg, Color? backgroundColor}) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 5),
      backgroundColor: backgroundColor ?? Colors.black,
    ),
  );
}
