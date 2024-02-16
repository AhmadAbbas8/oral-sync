import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/routing/app_router.dart';
import 'package:oralsync/core/widgets/custom_bottom_navigation_bar.dart';

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
