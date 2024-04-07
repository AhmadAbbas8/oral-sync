import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';

import '../../../../translations/locale_keys.g.dart';
import '../../../home_student_feature/presentation/pages/edit_profile_page.dart';
import '../../../home_student_feature/presentation/widgets/custom_app_bar_action_button.dart';

class ProfilePatientPage extends StatelessWidget {
  const ProfilePatientPage({super.key});

  static const routeName = '/profilePatientPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.profile).tr(),
        actions: [
          CustomAppBarActionButton(
            title: LocaleKeys.edit,
            onTap: () => log('messagemessage'),
          ),
          SizedBox(width: 5.w)
        ],
      ),
    );
  }
}
