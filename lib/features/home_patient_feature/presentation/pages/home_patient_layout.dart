import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/features/home_patient_feature/presentation/manager/free_paid_reservation_cubit/free_paid_reservation_cubit.dart';
import 'package:oralsync/features/home_patient_feature/presentation/manager/home_patient_cubit/home_patient_cubit.dart';
import 'package:oralsync/core/widgets/custom_app_drawer.dart';
import 'package:oralsync/features/home_patient_feature/presentation/pages/free_reservation_page.dart';
import 'package:oralsync/features/home_patient_feature/presentation/pages/messages_patient_page.dart';
import 'package:oralsync/features/home_patient_feature/presentation/pages/paid_reservation_page.dart';
import 'package:oralsync/features/home_patient_feature/presentation/pages/reservations_page.dart';

import '../../../../core/utils/icon_broken.dart';
import '../../../home_student_feature/presentation/pages/notification_page.dart';

class HomePatientLayoutPage extends StatelessWidget {
  const HomePatientLayoutPage({super.key});

  static const routeName = '/homePatientLayoutPage';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomePatientCubit(
            getNotificationsUseCase: ServiceLocator.instance(),
          )..getNotifications(),
        ),
        BlocProvider(
          create: (_) => ServiceLocator.instance<FreePaidReservationCubit>()..getFreePosts(),
        )
      ],
      child: BlocBuilder<HomePatientCubit, HomePatientState>(
        builder: (context, state) {
          var cubit = context.read<HomePatientCubit>();
          return Scaffold(
            drawer: _buildCustomAppDrawer(cubit),
            appBar: _buildAppBar(cubit, context),
            body:  LazyIndexedStack(
              index: cubit.currentNavIndex,
              children: const [
                FreeReservationPage(),
                PaidReservationPage(),
                MessagesPatientPage(),
                ReservationsPage(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (index) => cubit.navBarOnTap(index, context),
              currentIndex: cubit.currentNavIndex,
              items: List.generate(
                cubit.bottomNavTitle.length,
                (index) => BottomNavigationBarItem(
                  icon: Icon(cubit.bottomNavIcons[index]),
                  label: cubit.bottomNavTitle[index].tr(),
                  tooltip: cubit.bottomNavTitle[index].tr(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  CustomAppDrawer _buildCustomAppDrawer(HomePatientCubit cubit) {
    return CustomAppDrawer(
      email: cubit.patientModel.userDetails?.email ?? '',
      name:
          '${cubit.patientModel.userDetails?.firstName ?? ''} ${cubit.patientModel.userDetails?.lastName ?? ''}',
      profileImage: cubit.patientModel.profileImage ?? '',
    );
  }

  AppBar _buildAppBar(HomePatientCubit cubit, BuildContext context) {
    return AppBar(
      title: Text(
        cubit.appBarTitles[cubit.currentNavIndex],
      ).tr(),
      actions: [
        IconButton(
          onPressed: () => context.pushNamed(NotificationPage.routeName,
              arguments: cubit.notifications),
          icon: const Icon(
            IconBroken.Notification,
          ),
        ),
      ],
    );
  }
}
