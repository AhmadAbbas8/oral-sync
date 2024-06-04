import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/widgets/custom_app_drawer.dart';
import 'package:oralsync/features/home_doctor_feature/presentation/manager/doctor_cubit/doctor_cubit.dart';

import '../../../../translations/locale_keys.g.dart';

class HomeDoctorLayoutPage extends StatelessWidget {
  const HomeDoctorLayoutPage({super.key});

  static const routeName = '/doctorHomeLayout';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoctorCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.home).tr(),
        ),
        drawer: BlocBuilder<DoctorCubit, DoctorState>(
          builder: (context, state) {
            var cubit = context.read<DoctorCubit>();
            return CustomAppDrawer(
              name: '${cubit.doctorModel.userDetails?.firstName} ${cubit.doctorModel.userDetails?.lastName}',
              email: cubit.doctorModel.userDetails?.email ?? '',
              profileImage: cubit.doctorModel.profileImage ?? '',
            );
          },
        ),
      ),
    );
  }
}
