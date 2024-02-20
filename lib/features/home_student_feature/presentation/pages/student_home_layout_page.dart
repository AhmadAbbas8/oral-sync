import 'dart:developer';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/network/api/api_consumer.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/features/home_student_feature/presentation/manager/student_home_cubit/student_home_cubit.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/create_post_page.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/custom_drawer_student.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/notch_bottm_nav_bar.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

class StudentHomeLayoutPage extends StatelessWidget {
  static const String routeName = '/studentHomeLayoutPage';

  const StudentHomeLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentHomeCubit(),
      child: BlocBuilder<StudentHomeCubit, StudentHomeState>(
        builder: (context, state) {
          var cubit = context.read<StudentHomeCubit>();
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              title: Text(
                LocaleKeys.home.tr(),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    //just test something
                    ServiceLocator.instance<ApiConsumer>().post('CreatePost',data: {
                      "title": "Test title",
                      "content": "First context"
                    });
                  },
                  icon: const Icon(
                    IconBroken.Notification,
                  ),
                ),
              ],
            ),
            drawer: const CustomDrawerStudent(),
            body: LazyIndexedStack(
              index: cubit.currentNavIndex,
              children: cubit.homePages,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async =>
                  await context.pushNamed(CreatePostPage.routeName),
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
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
