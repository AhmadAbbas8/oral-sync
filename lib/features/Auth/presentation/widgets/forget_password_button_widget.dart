import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

class ForgetPasswordButtonWidget extends StatelessWidget {
  const ForgetPasswordButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: MediaQuery.sizeOf(context).width * .09),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {},
          child: const Text(
            LocaleKeys.forget_your_password,
            style: AppStyles.styleSize14,
          ).tr(),
        ),
      ),
    );
  }
}
