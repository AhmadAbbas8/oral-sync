import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oralsync/core/utils/assets_manager.dart';
import 'package:oralsync/core/utils/colors_palette.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsPalette.greyColor,
        // color: Colors.red,
        borderRadius: BorderRadius.circular(25),
      ),
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
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
                  AssetsManager.likeIconNotification,
                  height: 50,
                ),
              ),
              SizedBox(width: 5.w),
              Expanded(
                flex: 5,
                child: Text(
                  'Ahmed saber reacted to your post Hey There I am Ahmed Mohamed and how',
                ),
              ),
            ],
          ),
          Text(
            '12:45 , Feb 12,2022'
          ),
        ],
      ),
    );
  }
}
