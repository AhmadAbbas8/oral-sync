import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/utils/icon_broken.dart';

import '../../../../translations/locale_keys.g.dart';

class CustomButtonPhoto extends StatelessWidget {
  const CustomButtonPhoto({
    super.key,
    this.onTap,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      focusColor: Colors.red,
      highlightColor: Colors.white,
      hoverColor: Colors.white,
      splashColor: Colors.white,
      child: Row(
        children: [
          const Icon(IconBroken.Image_2),
          SizedBox(width: 20.w),
          const Text(
            LocaleKeys.photos,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ).tr()
        ],
      ),
    );
  }
}
