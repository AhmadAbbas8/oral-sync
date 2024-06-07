import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDoctorRatingWidget extends StatelessWidget {
  const CustomDoctorRatingWidget({
    super.key, required this.rateValue,
  });
  final double rateValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
         Text(
          '$rateValue',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 5.w),
        RatingBarIndicator(
          rating: rateValue,
          itemBuilder: (_, __) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 30.0.r,
        ),
      ],
    );
  }
}
