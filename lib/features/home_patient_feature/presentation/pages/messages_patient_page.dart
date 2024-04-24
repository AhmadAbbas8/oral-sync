import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/home_patient_feature/presentation/pages/chat_page.dart';

import '../../../../core/widgets/custom_search_widget.dart';

class MessagesPatientPage extends StatelessWidget {
  const MessagesPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CustomSearchWidget(
              onSearch: (value) {
                log(value, name: 'Custom Search Widget');
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              'Chats',
              style: AppStyles.styleSize28.copyWith(fontSize: 24),
            ),
          ),
          SliverList.builder(
            itemBuilder: (context, index) => ListTile(
              title: const Text(
                'Ahmad Abbas',
              ),
              subtitle: const Text(
                'Hello My Bro',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              leading: Hero(
                tag: index,
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/test/message_iamage.png'),
                ),
              ),
              onTap: () {
                context.pushNamed(ChatPage.routeName, arguments: index);
              },
            ),
            itemCount: 100,
          )
        ],
      ),
    );
  }
}
