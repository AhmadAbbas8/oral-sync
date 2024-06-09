import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/shared_data_layer/actions_data_layer/model/ratings_model.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/features/home_patient_feature/presentation/widgets/custom_doctor_rating_widget.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../widgets/custom_review_item_card_widget.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({super.key, required this.rates});

  final List<RatingModel> rates;
  static const routeName = '/RatingPage';

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          LocaleKeys.ratings_details,
        ).tr(),
      ),
      body: ListView.builder(
        itemCount: rates.length,
        itemBuilder: (context, index) {
          return SlideInLeft(
            child: CustomReviewItemCardWidget(review: rates[index]),
          );
        },
      ),
    );
  }
}

