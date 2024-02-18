import 'package:flutter/material.dart';

class HomeStudentPage extends StatelessWidget {
  static const  routeName = '/homeStudentPage';
  const HomeStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home'
        ),
      ),
    );
  }
}
