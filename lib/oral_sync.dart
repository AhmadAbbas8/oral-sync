import 'package:flutter/material.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/features/Auth/presentation/pages/login_page.dart';

class OralSyncApp extends StatelessWidget {
  const OralSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorsPalette.scaffoldColor,
      ),
      home: const LoginPage(),
    );
  }
}
