import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/cache_helper/shared_prefs_keys.dart';
import 'package:oralsync/core/helpers/check_language.dart';
import 'package:oralsync/core/helpers/snackbars.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/core/widgets/loading_widget.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/no_task_widget.dart';
import 'package:oralsync/features/reservations_feature/presentation/manager/reservations_cubit/reservations_cubit.dart';
import 'package:oralsync/features/reservations_feature/presentation/widgets/custom_steeper_reservations_widget.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../widgets/reservation_card_widget.dart';

class ReservationsPage extends StatelessWidget {
  const ReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
   var cache =  ServiceLocator.instance<CacheStorage>();
   var userJson = cache.getData(key: SharedPrefsKeys.user);
   var user  = UserModel.fromJson(json.decode(userJson));
    return BlocProvider(
      create: (_) => ServiceLocator.instance<ReservationsCubit>()
        ..getAllReservationsCompleted(),
      child: BlocConsumer<ReservationsCubit, ReservationsState>(
        listener: (context, state) {
          if (state is GetReservationsPatientError) {
            showCustomSnackBar(context,
                msg: isArabic(context)
                    ? state.model.messageAr ?? ''
                    : state.model.messageEn ?? '',
                backgroundColor: ColorsPalette.errorColor);
          }
        },
        builder: (context, state) {
          var cubit = context.read<ReservationsCubit>();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             if(user.userRole?.toUpperCase() == 'Patient'.toUpperCase()) const Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: CustomStepperReservationsWidget(),
                ),
              ),
              if(user.userRole?.toUpperCase() == 'Patient'.toUpperCase())   const Divider(
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              Expanded(
                flex: 3,
                child: Visibility(
                  visible: state is! GetReservationsPatientLoading,
                  replacement: const LoadingWidget(),
                  child: Visibility(
                    visible: cubit.reservations.isNotEmpty,
                    replacement: const Center(
                      child: NoTaskWidget(
                          title: LocaleKeys.there_is_no_any_reservations),
                    ),
                    child: ListView.builder(
                      itemBuilder: (_, index) => AppointmentCard(
                        reservation: cubit.reservations[index],
                      ),
                      itemCount: cubit.reservations.length,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
