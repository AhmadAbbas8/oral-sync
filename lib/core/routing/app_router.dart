import 'package:flutter/material.dart';
import 'package:oralsync/features/home_feature/presentation/pages/home_page.dart';
import 'package:oralsync/features/Auth/presentation/pages/login_page.dart';
import 'package:oralsync/features/Auth/presentation/pages/sign_up_doctor_page.dart';
import 'package:oralsync/features/Auth/presentation/pages/sign_up_options_page.dart';
import 'package:oralsync/features/Auth/presentation/pages/sign_up_patient_page.dart';
import 'package:oralsync/features/Auth/presentation/pages/sign_up_student_page.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/create_post_page.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/edit_profile_page.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/home_student_page.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/profile_student_page.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/settings_of_student_screen.dart';

import '../../features/home_student_feature/presentation/pages/student_home_layout_page.dart';

class AppRouter {
  AppRouter._();

  // BLoCs

  //
  static final navigatorKey = GlobalKey<NavigatorState>();
  //
  static final routes = {
    LoginPage.routeName: (context) => const LoginPage(),
    SignUpOptionsPage.routeName: (context) => const SignUpOptionsPage(),
    SignUpPatientPage.routeName: (context) => const SignUpPatientPage(),
    SignUpDoctorPage.routeName: (context) => const SignUpDoctorPage(),
    SignUpStudentPage.routeName: (context) => const SignUpStudentPage(),
    HomePage.routeName: (context) => const HomePage(),
    StudentHomeLayoutPage.routeName: (context) => const StudentHomeLayoutPage(),
    HomeStudentPage.routeName: (context) => const HomeStudentPage(),
    ProfileStudentPage.routeName: (context) => const ProfileStudentPage(),
    CreatePostPage.routeName: (context) => const CreatePostPage(),
    EditProfilePage.routeName: (context) => const EditProfilePage(),
    SettingsOfStudentScreen.routeName: (context) =>
        const SettingsOfStudentScreen(),
  };
}
