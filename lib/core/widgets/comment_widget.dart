import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../features/home_student_feature/data/models/comment_model.dart';
import '../utils/icon_broken.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.comment,
  });

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(comment.name ?? ''),
            Text(
              '${comment.timeCreated} ${comment.dateCreated}',
              style: const TextStyle(fontSize: 10),
            )
          ],
        ),
        leading: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(
            comment.profileImage ?? '',
          ),
        ),
        trailing: const Icon(IconBroken.Delete),
        subtitle: SelectableText(comment.content ?? 'null'));
  }
}
