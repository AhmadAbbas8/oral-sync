import 'package:flutter/cupertino.dart';

import 'notification_item.dart';

class NotificationPageBody extends StatelessWidget {
  const NotificationPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => NotificationItem(),
      itemCount: 50,

    );
  }
}
