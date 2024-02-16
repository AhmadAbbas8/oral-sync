import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/routing/app_router.dart';
import 'package:oralsync/core/widgets/the_main_drawer.dart';
import 'package:oralsync/features/student/presentation/widgets/no_task_widget.dart';

import '../bloc/student_bloc.dart';

class StudentHomeScreen extends StatelessWidget {
  static const String routeName = '/StudentHomeScreen';
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AppRouter.studentBloc,
      child: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_outlined,
                        ))),
              ],
              elevation: 0.0,
            ),
            drawer: const TheMainDrawer(),
            body: const Center(
              child: NoTaskWidget(),
            ),
          );
        },
      ),
    );
  }
}
