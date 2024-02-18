import 'package:flutter/material.dart';
import 'package:oralsync/core/widgets/circle_avatar.dart';
import 'package:oralsync/core/widgets/reaction_widget.dart';

class CreatedPostWidget extends StatelessWidget {
  const CreatedPostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.grey,
      )),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: const CircleAvatarWidget(),
              title: const Text('Mostafa Hassan'),
              subtitle: Text(DateTime.now().year.toString()),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Hi, I\'m mostafa hassan, student at faculty of engineering',
            ),
            //
            const SizedBox(height: 30),
            //
            Image.asset(
              'assets/student/images/Frame 50.png',
            ),
            const SizedBox(height: 30),
            //
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ReactionWidget(icon: Icons.thumb_up, numOfReactions: 5),
                ReactionWidget(icon: Icons.comment, numOfReactions: 2),
              ],
            )
          ],
        ),
      ),
    );
  }
}
