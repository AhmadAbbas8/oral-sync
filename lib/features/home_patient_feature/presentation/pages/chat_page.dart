import 'package:flutter/material.dart';
import 'package:oralsync/core/utils/icon_broken.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
    required this.index,
  });

  final int index;

  static const routeName = '/chatPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: ListTile(
          title: const Text('Ahmad Abbas'),
          trailing: IconButton(
            icon: const Icon(IconBroken.Call),
            onPressed: () {},
          ),
          subtitle: const Text(''),
          leading: Hero(
            tag: index,
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/test/message_iamage.png'),
            ),
          ),
        ),
      ),
    );
  }
}
