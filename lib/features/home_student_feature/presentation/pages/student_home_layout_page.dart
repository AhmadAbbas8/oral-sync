import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/features/home_doctor_feature/presentation/pages/doctor_home_page.dart';
import 'package:oralsync/features/home_student_feature/domain/use_cases/get_notifications_use_case.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/create_post_page.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/profile_student_page.dart';
import 'package:oralsync/core/widgets/custom_app_drawer.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/notch_bottm_nav_bar.dart';
import 'package:oralsync/features/messages_feature/presentation/pages/messages_page.dart';
import 'package:oralsync/features/reservations_feature/presentation/pages/reservations_page.dart';

import '../manager/student_cubit/student_cubit.dart';
import 'archive_student_page.dart';
import 'home_student_page.dart';
import 'message_student_page.dart';
import 'notification_page.dart';

class HomeStudentLayoutPage extends StatelessWidget {
  static const String routeName = '/studentHomeLayoutPage';

  const HomeStudentLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentCubit(
          getNotificationsUseCase:
              ServiceLocator.instance<GetNotificationsUseCase>())
        ..getNotifications(),
      child: BlocBuilder<StudentCubit, StudentState>(
        builder: (context, state) {
          var cubit = context.read<StudentCubit>();
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
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
            ),
            drawer: CustomAppDrawer(
              email: cubit.studentModel.userDetails?.email ?? '',
              name:
                  '${cubit.studentModel.userDetails?.firstName} ${cubit.studentModel.userDetails?.lastName}',
              profileImage: cubit.studentModel.profileImage ?? '',
            ),
            body: LazyIndexedStack(
              index: cubit.currentNavIndex,
              children: const [
                HomeStudentPage(),
                HomeDoctorPage(),
                MessagesPage(),
                ArchiveStudentPage(),
                ReservationsPage(),
                ProfileStudentPage(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async =>
                  await context.pushNamed(CreatePostPage.routeName),
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

            bottomNavigationBar: NotchBottomNavBar(
              icons: cubit.bottomNavIcons,
              titles: cubit.bottomNavTitle,
              currentIndex: cubit.currentNavIndex,
              onTap: (index) => cubit.navBarOnTap(index, context),
            ),
          );
        },
      ),
    );
  }
}
