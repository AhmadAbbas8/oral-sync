import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';

import '../../../../core/helpers/check_language.dart';
import '../../../../translations/locale_keys.g.dart';

class ChangeAccountToDoctorDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ChangeAccountToDoctorDialog({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rulesInEn = '''
- Once you click confirm, you will not be able to reverse your decision ❌
- All your posts will be deleted ❌
- Champion special ratings will still exist ✔
- All patient messages will remain available ✔
        ''';
    var rulesInAr = '''
- بمجرد الضغط على تأكيد لن تسطيع الرجوع عن قرارك ❌
- كل المنشورات الخاصة بك سوف يتم حذفها ❌
- التقييمات الخاصة بطل ستظل موجودة ✔
- كل الرسائل الخاصة بالمرضي ستظل موجودة ✔
    ''';

    return AlertDialog(
      title: const Text(
        LocaleKeys.are_you_sure_to_convert_your_account_to_a_doctor_s_account,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ).tr(),
      content: SingleChildScrollView(
        child: Text(isArabic(context) ? rulesInAr : rulesInEn),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Colors.green[400],
            ),
          ),
          child: const Text(LocaleKeys.cancel).tr(),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Colors.red[400],
            ),
          ),
          child: const Text(
            LocaleKeys.confirm,
            style: TextStyle(
              color: Colors.black,
            ),
          ).tr(),
        ),
      ],
    );
  }
}
