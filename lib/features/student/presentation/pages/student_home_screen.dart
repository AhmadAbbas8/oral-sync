import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/routing/app_router.dart';

import '../bloc/student_bloc.dart';

class StudentHomeScreen extends StatelessWidget {
  static const String routeName = '/StudentHomeScreen';
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AppRouter.studentBloc,
      child:  BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          return const Scaffold();
        },
      ),
    );
  }
}
