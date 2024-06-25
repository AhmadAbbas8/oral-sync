// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/helpers/check_language.dart';
import 'package:oralsync/core/helpers/custom_progress_indicator.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/helpers/snackbars.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/features/reservations_feature/data/models/reservation_model.dart';
import 'package:oralsync/features/reservations_feature/presentation/manager/reservations_cubit/reservations_cubit.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../home_student_feature/presentation/widgets/custom_app_bar_action_button.dart';
import '../../../home_student_feature/presentation/widgets/custom_text_form_field_create_post.dart';

class AddRatePage extends StatefulWidget {
  const AddRatePage({
    super.key,
    required this.reservation,
  });

  static const routeName = '/AddRatePage';
  final ReservationModel reservation;

  @override
  State<AddRatePage> createState() => _AddRatePageState();
}

class _AddRatePageState extends State<AddRatePage> {
  int _rating = 2;

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceLocator.instance<ReservationsCubit>(),
      child: BlocConsumer<ReservationsCubit, ReservationsState>(
        listener: (context, state) async {
          if (state is AddNewRateLoading) {
            showCustomProgressIndicator(context);
          }
          if (state is AddNewRateError) {
            context.pop();
            showCustomSnackBar(
              context,
              msg: isArabic(context)
                  ? state.model.messageAr ?? ''
                  : state.model.messageEn ?? '',
              backgroundColor: ColorsPalette.errorColor,
            );
          }
          if (state is AddNewRateSuccess) {
            context.pop();
            showCustomSnackBar(
              context,
              msg: isArabic(context)
                  ? state.model.messageAr ?? ''
                  : state.model.messageEn ?? '',
              backgroundColor: ColorsPalette.successColor,
            );
            await Future.delayed(const Duration(milliseconds: 500));
            context.pop();
          }
        },
        builder: (context, state) {
          var cubit = context.read<ReservationsCubit>();
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                LocaleKeys.add_rate,
              ).tr(),
              actions: [
                CustomAppBarActionButton(
                  title: LocaleKeys.add,
                  onTap: () {
                    cubit.addNewRate(
                      userId: widget.reservation.doctorId??'',
                      value: _rating,
                      comment: _commentController.text,
                      appointmentId: widget.reservation.id??0,
                    );
                    // if (cubit.captionController.text.isEmpty) {
                    //   showCustomSnackBar(
                    //     context,
                    //     msg: LocaleKeys.describe_your_request_in_details.tr(),
                    //     backgroundColor: Colors.red,
                    //   );
                    // } else {
                    //   cubit.createPost();
                    // }
                  },
                ),
                SizedBox(width: 5.w),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    LocaleKeys.rate_your_doctor_after_reservation.tr(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  RatingBar.builder(
                    initialRating: 2,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (_, __) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      _rating = rating.toInt();
                    },
                  ),
                  SizedBox(height: 20.h),
                  CustomTextFormFieldCreatePost(
                    textEditingController: _commentController,
                    caption: LocaleKeys.write_something,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
