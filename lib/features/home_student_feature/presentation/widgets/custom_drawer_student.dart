import 'package:flutter/material.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/Auth/presentation/pages/login_page.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/profile_student_page.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import 'custom_drawer_list_tile.dart';

class CustomDrawerStudent extends StatelessWidget {
  const CustomDrawerStudent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(
              'Ahmad@oralsync.com',
              style: AppStyles.styleSize14.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountName: Text(
              'Ahmad Abbas',
              style: AppStyles.styleSize14.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.black,
            ),
            decoration: const BoxDecoration(
              color: ColorsPalette.userDrawerHeaderBackground,
            ),
          ),
          CustomDrawerListTile(
            title: LocaleKeys.profile,
            icon: IconBroken.Profile,
            onTap: () {
              context.pushNamed(ProfileStudentPage.routeName);
            },
          ),
          const CustomDrawerListTile(
            title: LocaleKeys.settings,
            icon: IconBroken.Setting,
          ),
          const CustomDrawerListTile(
            title: LocaleKeys.privacy_policy,
            icon: IconBroken.Lock,
          ),
          const CustomDrawerListTile(
            title: LocaleKeys.contact_us,
            icon: IconBroken.Calling,
          ),
          Spacer(),
          CustomDrawerListTile(
            title: LocaleKeys.log_out,
            icon: IconBroken.Logout,
            onTap: () {
              ServiceLocator.instance<CacheStorage>().removeAllData().then(
                (value) {
                  context.pushNamedAndRemoveUntil(
                    LoginPage.routeName,
                    predicate: (route) => false,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
