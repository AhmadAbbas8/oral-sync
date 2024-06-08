import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors_palette.dart';

class CustomProfileButtonWidget extends StatelessWidget {
  const CustomProfileButtonWidget({
    super.key,
    this.onPressed,
    required this.title,
    required this.icon,
  });

  final void Function()? onPressed;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: ColorsPalette.buttonLoginColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Text(
            title,
          ).tr(),
          SizedBox(width: 20.w),
          Icon(
            icon,
          ),
        ],
      ),
    );
  }
}
