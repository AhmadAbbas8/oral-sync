import 'package:flutter/cupertino.dart';

import '../../../../translations/locale_keys.g.dart';
import '../../../../core/shared_data_layer/actions_data_layer/model/Notification_model.dart';
import 'no_task_widget.dart';
import 'notification_item.dart';

class NotificationPageBody extends StatelessWidget {
  const NotificationPageBody({super.key, required this.notifications});

  final List<NotificationModel> notifications;

  @override
  Widget build(BuildContext context) {
    return notifications.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) => NotificationItem(
              notification: notifications[index],
            ),
            itemCount: notifications.length,
          )
        : const Center(
            child: NoTaskWidget(
              title: LocaleKeys.there_is_no_any_notifications,
            ),
          );
  }
}
