import 'package:flutter/material.dart';

class ProfileStudentPage extends StatelessWidget {
  const ProfileStudentPage({super.key});
  static const  routeName = '/profileStudentPage';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Profile',
        ),
      ),
    );
  }
}
