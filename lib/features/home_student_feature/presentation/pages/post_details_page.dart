import 'package:flutter/material.dart';
import 'package:oralsync/features/home_student_feature/data/models/Student_post_model.dart';

class PostDetailsPage extends StatelessWidget {
  const PostDetailsPage({super.key});

  static const String routeName = '/PostDetailsPage';

  @override
  Widget build(BuildContext context) {
    var post = ModalRoute.of(context)!.settings.arguments as StudentPostModel;
    return const Scaffold();
  }
}
