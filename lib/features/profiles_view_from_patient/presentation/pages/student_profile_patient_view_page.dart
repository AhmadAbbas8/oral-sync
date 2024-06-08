import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../translations/locale_keys.g.dart';

class StudentProfilePatientViewPage extends StatelessWidget {
  const StudentProfilePatientViewPage({super.key});
static const routeName= '/StudentProfilePatientViewPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.profile).tr(),
      ),
    );
  }
}
