import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../translations/locale_keys.g.dart';
import '../utils/governorate.dart';
import 'dart:ui' as ui;

Future<String?> showGovernorateDialog(BuildContext context) async {
  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog.adaptive(
        title: const Text(LocaleKeys.select_governorate).tr(),
        content: SingleChildScrollView(
          child: ListBody(
            children: Governorate.governorates.map((governorate) {
              return Card(
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: Text(governorate.name,
                      textDirection: ui.TextDirection.rtl),
                  onTap: () {
                    Navigator.of(context).pop(governorate.name);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      );
    },
  );
}
