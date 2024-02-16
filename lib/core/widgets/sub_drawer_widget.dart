import 'package:flutter/material.dart';

class SubDrawerWidget extends StatelessWidget {
  final IconData? icon;
  final String? title;
  const SubDrawerWidget({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(icon),
        title: Text(
          title!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
