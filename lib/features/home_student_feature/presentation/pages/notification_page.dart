import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../widgets/notification_page_body.dart';

class NotificationPage extends StatelessWidget {
  static String routeName = '/notificationPage';

  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          LocaleKeys.notifications,
        ).tr(),
      ),
      body: NotificationPageBody(),
    );
  }
}
