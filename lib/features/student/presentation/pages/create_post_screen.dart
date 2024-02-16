import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/widgets/circle_avatar.dart';
import 'package:oralsync/features/student/presentation/bloc/student_bloc.dart';

class CreatePostScreen extends StatelessWidget {
  static const String routeName = "/CreatePostScreen";
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentBloc(),
      child: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Create Post'),
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Post',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ListTile(
                  leading: CircleAvatarWidget(),
                  title: Text('Mostafa Hassan'),
                ),
                //
                Container(
                  height: 180,
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 219, 214, 214),
                  ),
                ),
                //
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.image),
                    label: const Text('Photo'))
              ],
            ),
          );
        },
      ),
    );
  }
}
