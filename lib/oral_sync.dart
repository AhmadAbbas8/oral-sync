import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/cache_helper/SharedPrefsKeys.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/routing/app_router.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/features/Auth/presentation/pages/login_page.dart';
import 'package:oralsync/features/student/presentation/pages/student_home_screen.dart';

class OralSyncApp extends StatefulWidget {
  const OralSyncApp({super.key});

  @override
  State<OralSyncApp> createState() => _OralSyncAppState();
}

class _OralSyncAppState extends State<OralSyncApp> {
  String initialRoute = LoginPage.routeName;

  @override
  void initState() {
    stateInitialRoute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: ColorsPalette.scaffoldColor,
        ),
        initialRoute: initialRoute,
        navigatorKey: AppRouter.navigatorKey,
        routes: AppRouter.routes,
      ),
    );
  }

  void stateInitialRoute() {
    var cached = ServiceLocator.instance<CacheStorage>();
    bool? keepMeLoggedIn = cached.getData(key: SharedPrefsKeys.keepMeLoggedIn);
    if (keepMeLoggedIn ?? false) {
      initialRoute = StudentHomeScreen.routeName;
    }
  }
}
