import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/widgets/loading_widget.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/no_task_widget.dart';
import 'package:oralsync/features/reservations_feature/presentation/manager/reservations_cubit/reservations_cubit.dart';
import 'package:oralsync/features/reservations_feature/presentation/widgets/custom_steeper_reservations_widget.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../widgets/reservation_card_widget.dart';

class ReservationsPage extends StatelessWidget {
  const ReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceLocator.instance<ReservationsCubit>()
        ..getAllReservationsCompleted(),
      child: BlocConsumer<ReservationsCubit, ReservationsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = context.read<ReservationsCubit>();
          return Column(
            children: [
              const Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: CustomStepperReservationsWidget(),
                ),
              ),
              const Divider(
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
                    replacement: const NoTaskWidget(
                        title: LocaleKeys.there_is_no_any_reservations),
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
