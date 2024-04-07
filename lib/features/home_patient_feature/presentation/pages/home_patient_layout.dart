import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/features/home_patient_feature/presentation/manager/home_patient_cubit/home_patient_cubit.dart';
import 'package:oralsync/core/widgets/custom_app_drawer.dart';

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
              profileImage: cubit.patientModel.profileImage??'',
            );
          },
        ),
        appBar: AppBar(),
      ),
    );
  }
}
