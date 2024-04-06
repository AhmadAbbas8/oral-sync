import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/features/home_patient_feature/presentation/manager/home_patient_cubit/home_patient_cubit.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/custom_drawer_student.dart';

class HomePatientLayoutPage extends StatelessWidget {
  const HomePatientLayoutPage({super.key});

  static const routeName = '/homePatientLayoutPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePatientCubit(),
      child: Scaffold(
        drawer: BlocBuilder<HomePatientCubit, HomePatientState>(
          builder: (context, state) {
            var cubit = context.read<HomePatientCubit>();
            return CustomAppDrawer(
              email: cubit.patientModel.userDetails?.email??'',
              name: '${cubit.patientModel.userDetails?.firstName??''} ${cubit.patientModel.userDetails?.lastName??''}',
              profileImage: 'profileImage',
            );
          },
        ),
        appBar: AppBar(),
      ),
    );
  }
}
