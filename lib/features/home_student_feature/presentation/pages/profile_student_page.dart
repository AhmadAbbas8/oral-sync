import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/widgets/rating_wodget.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/custom_app_bar_action_button.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/info_widget.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../../../../core/widgets/circle_avatar.dart';
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
        body: const SingleChildScrollView(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatarWidget(),
              //
              InfoWidget(title: "Ahmad Mohamad", icon: Icons.person),
              InfoWidget(title: 'Ahmad@oralSync.com', icon: Icons.mail),
              InfoWidget(title: '0123456789', icon: Icons.phone),
              InfoWidget(title: "Male", icon: Icons.male),
              InfoWidget(
                  title: 'Student at faculty of enginnering',
                  icon: Icons.house),
              InfoWidget(
                  title: 'Fourth academic year', icon: Icons.arrow_forward),

              InfoWidget(title: "Cairo, Nasr city", icon: Icons.location_city),
              //
              Text(
                "Grade",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              RatingWidget()
            ],
          ),
        )));
  }
}
