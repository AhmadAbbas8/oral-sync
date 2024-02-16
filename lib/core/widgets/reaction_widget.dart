import 'package:flutter/material.dart';

class ReactionWidget extends StatelessWidget {
  final IconData? icon;
  final int? numOfReactions;

  const ReactionWidget(
      {super.key, required this.icon, required this.numOfReactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 188, 176, 176)),
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(icon),
        label: Text(numOfReactions.toString()),
      ),
    );
  }
}
