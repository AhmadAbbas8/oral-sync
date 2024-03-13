import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBarWidget extends StatelessWidget {
  const CustomRatingBarWidget({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      margin: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Color(0xFF33cccccc),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 16.w,
          ),
           Text(
            '$rating',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 5.w),
          RatingBarIndicator(
            rating: rating,
            itemBuilder: (_, __) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 50.0,
          ),
        ],
      ),
    );
  }
}
