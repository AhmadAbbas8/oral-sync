import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/routing/app_router.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/features/Auth/presentation/pages/login_page.dart';

class OralSyncApp extends StatelessWidget {
  const OralSyncApp({super.key});

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
        initialRoute: LoginPage.routeName,
        navigatorKey: AppRouter.navigatorKey,
        routes: AppRouter.routes,
      ),
    );
  }
}
