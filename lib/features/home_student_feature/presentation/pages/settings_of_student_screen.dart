import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_switch/flutter_switch.dart";

import "../../../../core/helpers/check_language.dart";
import "../../../../translations/locale_keys.g.dart";

class SettingsOfStudentScreen extends StatefulWidget {
  static const String routeName = "/SettingsOfStudentScreen";

  const SettingsOfStudentScreen({super.key});

  @override
  State<SettingsOfStudentScreen> createState() =>
      _SettingsOfStudentScreenState();
}

class _SettingsOfStudentScreenState extends State<SettingsOfStudentScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.settings).tr(),
      ),
      body: Container(
        height: size.height * 0.7,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xFFF9F9F9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text(
                LocaleKeys.language,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
              trailing: FittedBox(
                child: FlutterSwitch(
                  value: isArabic(context) ? true : false,
                  onToggle: (state) async => onChangeLanguage(state, context),
                  duration: const Duration(milliseconds: 360),
                  activeIcon: const Text('AR'),
                  inactiveIcon: const Text('EN'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onChangeLanguage(bool state, BuildContext context) async {
    {
      if (state) {
        await context.setLocale(const Locale('ar'));
      } else {
        await context.setLocale(const Locale('en'));
      }
      await WidgetsBinding.instance.performReassemble();
      setState(() {});
    }
  }
}
