import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/cache_helper/shared_prefs_keys.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/routing/app_router.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/Auth/presentation/pages/login_page.dart';

import 'features/home_student_feature/presentation/pages/student_home_layout_page.dart';

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
          appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 0,
            titleTextStyle: AppStyles.styleSize28.copyWith(
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            elevation: 20,
            selectedItemColor: ColorsPalette.buttonLoginColor,
            unselectedItemColor: Colors.black,
            backgroundColor: Colors.grey,
            selectedIconTheme: IconThemeData(
              size: 30,
            ),
            unselectedIconTheme: IconThemeData(
              color: Colors.black,
            ),
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: TextStyle(
              color: Colors.black,
            ),
            showSelectedLabels: true,
            showUnselectedLabels: true,
          ),

          drawerTheme: DrawerThemeData(
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
              ),
            ),
            width: MediaQuery.sizeOf(context).width * .6,
          ),
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
      initialRoute = StudentHomeLayoutPage.routeName;
    }
  }
}
