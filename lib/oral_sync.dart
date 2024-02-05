import 'package:flutter/material.dart';
import 'package:oralsync/core/app_router.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/features/Auth/presentation/pages/login_page.dart';

class OralSyncApp extends StatelessWidget {
  const OralSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: ColorsPalette.scaffoldColor,
      ),
      initialRoute: LoginPage.routeName,
      navigatorKey: AppRouter.navigatorKey,
      routes: AppRouter.routes,
    );
  }
}
