import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/core/widgets/custom_app_drawer.dart';
import 'package:oralsync/features/home_doctor_feature/presentation/manager/doctor_cubit/doctor_cubit.dart';
import 'package:oralsync/features/home_doctor_feature/presentation/pages/doctor_home_page.dart';
import 'package:oralsync/features/home_doctor_feature/presentation/pages/doctor_messages_page.dart';
import 'package:oralsync/features/reservations_feature/presentation/pages/reservations_page.dart';

import '../../../../translations/locale_keys.g.dart';
import '../../../messages_feature/presentation/pages/messages_page.dart';

class HomeDoctorLayoutPage extends StatelessWidget {
  const HomeDoctorLayoutPage({super.key});

  static const routeName = '/doctorHomeLayout';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoctorCubit(),
      child: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          var cubit = context.read<DoctorCubit>();
          return Scaffold(
            appBar: AppBar(
              title: const Text(LocaleKeys.home).tr(),
            ),
            drawer: CustomAppDrawer(
              name:
                  '${cubit.doctorModel.userDetails?.firstName} ${cubit.doctorModel.userDetails?.lastName}',
              email: cubit.doctorModel.userDetails?.email ?? '',
              profileImage: cubit.doctorModel.profileImage ?? '',
            ),
            body: LazyIndexedStack(
              index: cubit.currentIndex,
              children: const [
                HomeDoctorPage(),
                // DoctorMessagesPage(),
                MessagesPage(),
                ReservationsPage(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) => cubit.onChangeBottomNav(context, value),
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(IconBroken.Home),
                  tooltip: LocaleKeys.home.tr(),
                  label: LocaleKeys.home.tr(),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(IconBroken.Message),
                  tooltip: LocaleKeys.messages.tr(),
                  label: LocaleKeys.messages.tr(),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(IconBroken.Wallet),
                  tooltip: LocaleKeys.reservations.tr(),
                  label: LocaleKeys.reservations.tr(),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(IconBroken.Profile),
                  tooltip: LocaleKeys.profile.tr(),
                  label: LocaleKeys.profile.tr(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
