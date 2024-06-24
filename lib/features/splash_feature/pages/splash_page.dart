import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';

import '../../../core/cache_helper/cache_storage.dart';
import '../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../core/service_locator/service_locator.dart';
import '../../Auth/data/models/user_model.dart';
import '../../Auth/presentation/pages/login_page.dart';
import '../../home_doctor_feature/presentation/pages/doctor_home_layout.dart';
import '../../home_patient_feature/presentation/pages/home_patient_layout.dart';
import '../../home_student_feature/presentation/pages/student_home_layout_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const routeName = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  String initialRoute = LoginPage.routeName;

  late final AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..forward();
    stateInitialRoute();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        context.pushNamedAndRemoveUntil(initialRoute,predicate: (route) => false);
        print('completed');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DefaultTextStyle(
              style: GoogleFonts.aleo(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              child: AnimatedTextKit(
                // repeatForever: true,
                totalRepeatCount: 3,
                animatedTexts: [
                  TyperAnimatedText('Welcome to OralSync App' ,speed: const Duration(milliseconds: 90)),
                ],

              ),
            ),
            Lottie.asset(
              'assets/configs/lottie_splash.json',
              fit: BoxFit.fitHeight,
              controller: _controller,
              onLoaded: (composition) {
                // _controller
                //   ..duration = composition.duration
                //   ..forward();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void stateInitialRoute() {
    var cached = ServiceLocator.instance<CacheStorage>();
    bool? keepMeLoggedIn = cached.getData(key: SharedPrefsKeys.keepMeLoggedIn);
    if (keepMeLoggedIn ?? false) {
      initialRoute = validateInitialRouteForUserRole();
    }
  }

  validateInitialRouteForUserRole() {
    var cache = ServiceLocator.instance<CacheStorage>();
    var user = json.decode(cache.getData(key: SharedPrefsKeys.user));
    var role = UserModel.fromJson(user).userRole?.toUpperCase() ?? '';
    if (role == 'Student'.toUpperCase()) {
      return HomeStudentLayoutPage.routeName;
    } else if (role == 'Patient'.toUpperCase()) {
      return HomePatientLayoutPage.routeName;
    } else if (role == 'Doctor'.toUpperCase()) {
      return HomeDoctorLayoutPage.routeName;
    } else {
      return LoginPage.routeName;
    }
  }
}
