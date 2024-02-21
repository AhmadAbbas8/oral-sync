import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/custom_app_bar_action_button.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import 'edit_profile_page.dart';

class ProfileStudentPage extends StatelessWidget {
  const ProfileStudentPage({super.key});

  static const routeName = '/profileStudentPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.profile).tr(),
        actions: [
          CustomAppBarActionButton(
            title: LocaleKeys.edit,
            onTap: () => context.pushNamed(
              EditProfilePage.routeName,
            ),
          ),
          SizedBox(width: 5.w)
        ],
      ),
      body: const Center(
        child: Text(
          'Profile',
        ),
      ),
    );
  }
}
