import 'package:flutter/material.dart';
import 'package:oralsync/features/home_fearure/presentation/pages/home_page.dart';
import 'package:oralsync/features/Auth/presentation/pages/login_page.dart';
import 'package:oralsync/features/Auth/presentation/pages/sign_up_doctor_page.dart';
import 'package:oralsync/features/Auth/presentation/pages/sign_up_options_page.dart';
import 'package:oralsync/features/Auth/presentation/pages/sign_up_patient_page.dart';
import 'package:oralsync/features/Auth/presentation/pages/sign_up_student_page.dart';
import 'package:oralsync/features/student/presentation/bloc/student_bloc.dart';
import 'package:oralsync/features/student/presentation/pages/student_home_screen.dart';

class AppRouter {
  AppRouter._();

  // BLoCs
  static final studentBloc = StudentBloc();

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
    StudentHomeScreen.routeName: (context) => const StudentHomeScreen(),
  };
}
