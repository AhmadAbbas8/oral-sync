import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

class StudentHomeLayoutPage extends StatelessWidget {
  static const String routeName = '/studentHomeLayoutPage';

  const StudentHomeLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          LocaleKeys.home.tr(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              IconBroken.Notification,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.zero,
        notchMargin: 8,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: 1,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(IconBroken.Home),
              label: LocaleKeys.home.tr(),
              tooltip: LocaleKeys.home.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(IconBroken.Message),
              label: LocaleKeys.messages.tr(),
              tooltip: LocaleKeys.messages.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.archive_outlined),
              label: LocaleKeys.archived.tr(),
              tooltip: LocaleKeys.archived.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(IconBroken.Profile),
              label: LocaleKeys.profile.tr(),
              tooltip: LocaleKeys.profile.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
