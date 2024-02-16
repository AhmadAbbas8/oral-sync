import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/routing/app_router.dart';
import 'package:oralsync/core/widgets/custom_bottom_navigation_bar.dart';
import 'package:oralsync/core/widgets/the_main_drawer.dart';
import 'package:oralsync/features/student/presentation/pages/create_post_screen.dart';

import '../bloc/student_bloc.dart';

class StudentLayoutScreen extends StatelessWidget {
  static const String routeName = '/StudentLayoutScreen';
  const StudentLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AppRouter.studentBloc,
      child: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          final studentBloc = AppRouter.studentBloc;
          return SafeArea(
              child: Scaffold(
            body: studentBloc.theBody[studentBloc.currentIndex],
            drawer: const TheMainDrawer(),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  context.pushNamed(
                    CreatePostScreen.routeName,
                  );
                },
                child: const Icon(Icons.add)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: CustomBottomNavigationBar(
                currentIndex: studentBloc.currentIndex,
                onTap: (index) => studentBloc
                    .add(ChangeBottomNavigationBarIndexEvent(index))),
          ));
        },
      ),
    );
  }
}
