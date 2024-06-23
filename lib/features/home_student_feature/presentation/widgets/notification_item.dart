import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/helpers/check_language.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/colors_palette.dart';
import '../../../../core/shared_data_layer/actions_data_layer/model/Notification_model.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    String arabicContent = 'قام (${notification.sender?.replaceAll('_', ' ')}) بالتفاعل مع المنشور الخاص بك';
    String englishContent = '(${notification.sender?.replaceAll('_', ' ')}) interacted with your post';
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsPalette.greyColor,
        // color: Colors.red,
        borderRadius: BorderRadius.circular(25),
      ),
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 1,
                child: SvgPicture.asset(
                  notification.type?.toUpperCase() == 'LIKE'
                      ? AssetsManager.likeIconNotification
                      : AssetsManager.commentIconNotification,
                  height: 50,
                ),
              ),
              SizedBox(width: 5.w),
              Expanded(
                flex: 5,
                child: Text(
                  isArabic(context) ? arabicContent : englishContent,
                ),
              ),
            ],
          ),
          Text(
            '${notification.timeCreated} ,${DateFormat("MMM dd, yyyy",'en').format(
              DateFormat("yyyy/MM/dd",'en')
                  .parse(notification.dateCreated ?? '2001/08/01'),
            )}',
          ),
        ],
      ),
    );
  }
}
