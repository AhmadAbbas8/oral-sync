
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class KeepMeLoggedInWidget extends StatelessWidget {
  const KeepMeLoggedInWidget({
    super.key,
    required this.value,
    this.onChanged,
    required this.title,
  });

  final bool value;
  final void Function(bool?)? onChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile.adaptive(
      contentPadding: EdgeInsets.zero,
      splashRadius: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      checkboxShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      controlAffinity: ListTileControlAffinity.leading,
      value: value,
      onChanged: onChanged,
      title: Text(
        title.tr(),
        style: const TextStyle(),
      ),
    );
  }
}
