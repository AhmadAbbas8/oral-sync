import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/helpers/check_language.dart';
import 'package:oralsync/core/helpers/snackbars.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/core/widgets/loading_widget.dart';
import 'package:oralsync/features/home_patient_feature/presentation/manager/free_paid_reservation_cubit/free_paid_reservation_cubit.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/no_task_widget.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../widgets/custom_free_post_widget.dart';

class FreeReservationPage extends StatelessWidget {
  const FreeReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FreePaidReservationCubit, FreePaidReservationState>(
        builder: (_, __) {
          return RefreshIndicator(
            onRefresh: () =>
                context.read<FreePaidReservationCubit>().onRefresh(),
            child: BlocConsumer<FreePaidReservationCubit,
                FreePaidReservationState>(
              listener: (context, state) {
                if (state is LikeUnLikePostSuccess) {
                  showCustomSnackBar(
                    context,
                    msg: isArabic(context)
                        ? state.responseModel.messageAr ?? ''
                        : state.responseModel.messageEn ?? '',
                    backgroundColor: state.responseModel.statusCode == 200
                        ? ColorsPalette.successColor
                        : ColorsPalette.errorColor,
                  );
                }
                if (state is FetchFreePostsError) {
                  showCustomSnackBar(context,
                      msg: isArabic(context)
                          ? state.model?.messageAr ?? ''
                          : state.model?.messageEn ?? '',
                      backgroundColor: ColorsPalette.errorColor);
                }
              },
              builder: (_, state) {
                var cubit = context.read<FreePaidReservationCubit>();
                if (state is FetchFreePostsLoading && cubit.freePosts.isEmpty) {
                  return const LoadingWidget();
                } else if (cubit.freePosts.isNotEmpty) {
                  return CustomFreePostsWidget(cubit: cubit);
                }
                return const Center(
                    child: NoTaskWidget(title: LocaleKeys.no_tasks));
              },
            ),
          );
        },
      ),
    );
  }
}
