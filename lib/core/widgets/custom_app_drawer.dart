import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/cache_helper/shared_prefs_keys.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';
import 'package:oralsync/features/Auth/presentation/pages/login_page.dart';
import 'package:oralsync/features/contact_us_feature/presentation/pages/contact_us_page.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/profile_student_page.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/settings_of_student_screen.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../../features/Auth/data/data_sources/auth_local_data_source.dart';
import '../../features/doctor_profile_feature/presentation/pages/doctor_profile_page.dart';
import '../../features/home_patient_feature/presentation/pages/profile_patient_page.dart';
import 'custom_drawer_list_tile.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({
    super.key,
    required this.name,
    required this.email,
    required this.profileImage,
  });

  final String name;
  final String email;
  final String profileImage;

  @override
  Widget build(BuildContext context) {
    log('custom drawer ----$profileImage');
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(
              email,
              style: AppStyles.styleSize14.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountName: Text(
              name,
              style: AppStyles.styleSize14.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black,
              backgroundImage:  NetworkImage(profileImage, headers: const {'Cache-Control': 'no-cache'},),
            ),
            decoration: const BoxDecoration(
              color: ColorsPalette.userDrawerHeaderBackground,
            ),
          ),
          CustomDrawerListTile(
            title: LocaleKeys.profile,
            icon: IconBroken.Profile,
            onTap: () {
              context.pushNamed(getRouteForProfilePage());
            },
          ),
          CustomDrawerListTile(
            title: LocaleKeys.settings,
            icon: IconBroken.Setting,
            onTap: () {
              context.pushNamed(SettingsOfStudentScreen.routeName);
            },
          ),
          const CustomDrawerListTile(
            title: LocaleKeys.privacy_policy,
            icon: IconBroken.Lock,
          ),
          CustomDrawerListTile(
            title: LocaleKeys.contact_us,
            icon: IconBroken.Calling,
            onTap: () async => await context.pushNamed(ContactUsPage.routeName),
          ),
          const Spacer(),
          CustomDrawerListTile(
            title: LocaleKeys.log_out,
            icon: IconBroken.Logout,
            onTap: () {
              ServiceLocator.instance<AuthLocalDataSource>().logout().then(
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

  String getRouteForProfilePage() {
    var cache = ServiceLocator.instance<CacheStorage>();
    var user = json.decode(cache.getData(key: SharedPrefsKeys.user));
    var role = UserModel.fromJson(user).userRole?.toUpperCase() ?? '';
    if (role == 'Student'.toUpperCase()) {
      return ProfileStudentPage.routeName;
    } else if (role == 'doctor'.toUpperCase()) {
      return DoctorProfilePage.routeName;
    } else {
      return ProfilePatientPage.routeName;
    }
  }
}
