import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/widgets/circle_avatar.dart';
import 'package:oralsync/features/home_student_feature/presentation/manager/student_bloc.dart';


class StudentProfileScreen extends StatelessWidget {
  static const String routeName = '/StudentProfileScreen';
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentBloc(),
      child: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("My Profile"),
              actions: [
                TextButton(
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Edit"),
                    ))
              ],
            ),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatarWidget(),
                  Text(
                    "Mostafa Hassan",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //
                  Text(
                    "----- mostafahassan@gmail.com",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "----- 01234567891011",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "----- Male",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "----- Student at Al-Azahr University",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "----- Very Good",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "----- Fourth Academic Year",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "----- Egypt, Cairo, Nasr City",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
