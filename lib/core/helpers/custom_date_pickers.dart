import 'package:flutter/material.dart';

Future<DateTime?> showCustomDatePicker(
  BuildContext context, {
  String? titleText,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  return await showDatePicker(
    context: context,
    firstDate: firstDate ?? DateTime(1900),
    lastDate: lastDate ?? DateTime(2099),
    initialDate: initialDate ?? DateTime.now(),
    helpText: titleText,
  );
}
