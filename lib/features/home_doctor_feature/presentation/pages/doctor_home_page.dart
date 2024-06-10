import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:oralsync/core/helpers/check_language.dart';
import 'package:oralsync/core/helpers/snackbars.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/core/widgets/loading_widget.dart';
import 'package:oralsync/features/home_doctor_feature/presentation/manager/home_doctor_cubit/home_doctor_cubit.dart';
import 'package:oralsync/features/home_doctor_feature/presentation/widgets/custom_home_doctor_card_widget.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/no_task_widget.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

class HomeDoctorPage extends StatelessWidget {
  const HomeDoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceLocator.instance<HomeDoctorCubit>()
        ..getWaitingReservationsForDoctor(),
      child: Scaffold(
        body: BlocConsumer<HomeDoctorCubit, HomeDoctorState>(
          listener: (context, state) {
            if (state is GetReservationsWaitingDoctorError) {
              showCustomSnackBar(context,
                  msg: isArabic(context)
                      ? state.model.messageAr ?? ''
                      : state.model.messageEn ?? '',
                  backgroundColor: ColorsPalette.errorColor);
            }
          },
          builder: (context, state) {
            var cubit = context.read<HomeDoctorCubit>();
            return RefreshIndicator(
              onRefresh: () async =>
                  await cubit.getWaitingReservationsForDoctor(),
              child: Visibility(
                visible: state is! GetReservationsWaitingDoctorLoading,
                replacement: const Center(
                  child: LoadingWidget(),
                ),
                child: Visibility(
                  visible: cubit.reservations.isNotEmpty,
                  replacement: const Center(
                    child: NoTaskWidget(
                        title: LocaleKeys.there_is_no_any_reservations),
                  ),
                  child: AnimationLimiter(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: cubit.reservations.length,
                      itemBuilder: (_, index) => AnimationConfiguration.staggeredList(
                        position: index,
                        duration:  const Duration(milliseconds: 1000),
                        child: SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: CustomHomeDoctorCardWidget(
                              reservation: cubit.reservations[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
