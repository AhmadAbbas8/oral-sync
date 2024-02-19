import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LikeCommentWidget extends StatelessWidget {
  const LikeCommentWidget({
    super.key,
    required this.icon,
    required this.count,
    this.onTap,
  });

  final IconData icon;
  final int count;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 100.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: const Color(0xFFE6EEFA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(width: 9.w),
            Text('$count'),
          ],
        ),
      ),
    );
  }
}
