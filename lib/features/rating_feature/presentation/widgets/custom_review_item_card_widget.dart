import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../../../../core/shared_data_layer/actions_data_layer/model/ratings_model.dart';
import '../../../../core/utils/icon_broken.dart';
import '../../../home_patient_feature/presentation/widgets/custom_doctor_rating_widget.dart';

class CustomReviewItemCardWidget extends StatelessWidget {
  final RatingModel review;

  const CustomReviewItemCardWidget({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  // backgroundImage: NetworkImage(review.image),
                  radius: 30.0,
                  child: Icon(
                    IconBroken.Profile,
                    size: 50,
                  ),
                ),
                SizedBox(width: 10.0.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      LocaleKeys.unknown,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                    SizedBox(height: 5.0.h),
                    CustomDoctorRatingWidget(
                        rateValue: review.value?.toDouble() ?? 0),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0.h),
            Text(
              review.comment ?? '',
              style: const TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 10.0.h),
            Text(
              '${review.dateCreated} ${review.timeCreated}',
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
