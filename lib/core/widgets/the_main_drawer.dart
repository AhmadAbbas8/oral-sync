import 'package:flutter/material.dart';

import 'sub_drawer_widget.dart';

class TheMainDrawer extends StatelessWidget {
  const TheMainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          const SubDrawerWidget(icon: Icons.settings, title: 'Settings'),
          const SubDrawerWidget(
              icon: Icons.privacy_tip, title: 'Privacy Police'),
          const SubDrawerWidget(icon: Icons.person_3, title: 'Contact us'),
          const SubDrawerWidget(
              icon: Icons.question_mark_rounded, title: 'App Features'),
        ],
      ),
    );
  }
}
