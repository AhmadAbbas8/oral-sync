import 'package:flutter/material.dart';

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundImage:
          AssetImage('assets/student/images/IMG-20180709-WA0006.jpg'),
      maxRadius: 50,
    );
  }
}
