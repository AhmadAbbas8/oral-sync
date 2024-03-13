import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oralsync/features/home_student_feature/data/models/Notification_model.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../widgets/notification_page_body.dart';

class NotificationPage extends StatelessWidget {
  static const String routeName = '/notificationPage';
final  List<NotificationModel> notifications ;
  const NotificationPage({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          LocaleKeys.notifications,
        ).tr(),
      ),
      body: NotificationPageBody(notifications: notifications),
    );
  }
}
