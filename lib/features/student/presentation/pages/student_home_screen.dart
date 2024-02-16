import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/routing/app_router.dart';
import 'package:oralsync/core/widgets/sub_drawer_widget.dart';
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
            drawer: Drawer(
              backgroundColor: const Color(0xFFE6EEFA),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.grey,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        Text('Mostafa Hassan'),
                        Text('51654446464'),
                      ],
                    ),
                  ),
                  const SubDrawerWidget(icon: Icons.person, title: 'Profile'),
                  const SubDrawerWidget(
                      icon: Icons.settings, title: 'Settings'),
                  const SubDrawerWidget(
                      icon: Icons.privacy_tip, title: 'Privacy Police'),
                  const SubDrawerWidget(
                      icon: Icons.person_3, title: 'Contact us'),
                  const SubDrawerWidget(
                      icon: Icons.question_mark_rounded, title: 'App Features'),
                ],
              ),
            ),
            body: const Center(
              child: NoTaskWidget(),
            ),
          );
        },
      ),
    );
  }
}
