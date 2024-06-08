// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

class InfoWidget extends StatelessWidget {
  final String title;
  final IconData icon;

  const InfoWidget({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return FlipInY(
      duration: const Duration(milliseconds: 1500),
      child: Container(
        height: 50.h,
        margin: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Color(0xFF33cccccc),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 16.w,
            ),
            Icon(icon),
            SizedBox(
              width: 32.w,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(overflow: TextOverflow.fade),
                // maxLines: 3,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// name
// image
// notes
// fees
// date
// location
//
//{ "Scheduled", "Completed", "Cancelled" };
