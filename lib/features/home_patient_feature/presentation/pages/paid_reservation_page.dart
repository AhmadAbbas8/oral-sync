import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/widgets/loading_widget.dart';
import 'package:oralsync/features/home_patient_feature/presentation/manager/paid_reservation_cubit/paid_reservation_cubit.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/no_task_widget.dart';
import '../widgets/doctor_item_widget.dart';

class PaidReservationPage extends StatelessWidget {
  const PaidReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaidReservationCubit, PaidReservationState>(
      builder: (context, state) {
        if (state is FetchDoctorsLoading) {
          return const LoadingWidget();
        } else if (state is FetchDoctorsSuccess && state.doctors.isNotEmpty) {
          return RefreshIndicator.adaptive(
            onRefresh:() => context.read<PaidReservationCubit>().getAllDoctors(),
            child: ListView.builder(
              itemBuilder: (_, index) =>
                  DoctorItemWidget(doctor: state.doctors[index]),
              itemCount: state.doctors.length,
            ),
          );
        } else {
          return const Center(
            child: NoTaskWidget(title: 'there is no doctors'),
          );
        }
      },
    );
  }
}
