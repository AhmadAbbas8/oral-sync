import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oralsync/core/utils/assets_manager.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/core/utils/size_helper.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/like_comment_widget.dart';

class PostItemWidget extends StatelessWidget {
  const PostItemWidget({
    super.key,
    required this.userName,
    required this.postDate,
    required this.caption,
    required this.images,
    required this.likesCount,
    required this.commentsCount,
    this.onTaLike,
    this.onTaComment,
    this.onPressedEdit,
    required this.profileURL,
  });

  final String userName;
  final String postDate;
  final String caption;
  final List<String> images;
  final int likesCount;
  final int commentsCount;
  final String profileURL;
  final Function()? onTaLike;
  final Function()? onTaComment;
  final Function()? onPressedEdit;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading:  CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                  profileURL,
              ),
              ),
            title: Text(
              userName,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(postDate),
            trailing: IconButton(
              icon: const Icon(IconBroken.Edit),
              onPressed: onPressedEdit,
            ),
          ),
          SelectableText(caption),
          SizeHelper.defSizedBoxField,
          if (images.isNotEmpty)
            SizedBox(
              width: double.infinity,
              height: size.height * .5,
              child: GridView.builder(
                itemCount: images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 5 / 4,
                  // crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap: () async {
                    await showImageViewer(
                        context, Image.network(images[index]).image,
                        swipeDismissible: true, doubleTapZoomable: true);
                  },
                  child: CachedNetworkImage(
                    imageUrl: images[index],
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          SizeHelper.defSizedBoxField,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LikeCommentWidget(
                icon: IconBroken.Heart,
                count: likesCount,
                onTap: onTaLike,
              ),
              LikeCommentWidget(
                icon: FontAwesomeIcons.comment,
                count: commentsCount,
                onTap: onTaComment,
              ),
            ],
          )
        ],
      ),
    );
  }
}
