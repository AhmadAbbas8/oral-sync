import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/cache_helper/shared_prefs_keys.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/core/utils/size_helper.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/like_comment_widget.dart';
import 'package:oralsync/features/profiles_view_from_patient/presentation/pages/student_profile_patient_view_page.dart';

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
    this.onPressedArchive,
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
  final Function()? onPressedArchive;

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
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                profileURL,
              ),
            ),
            title: GestureDetector(
              onTap: () {
                String user = ServiceLocator.instance<CacheStorage>()
                    .getData(key: SharedPrefsKeys.user);
                var userModel = UserModel.fromJson(json.decode(user));
                var role = userModel.userRole?.toUpperCase() ?? '';
                if (role == 'Patient'.toUpperCase()) {
                  context.pushNamed(StudentProfilePatientViewPage.routeName);
                }
              },
              child: Text(
                userName,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            subtitle: Text(postDate),
            trailing: IconButton(
              icon: const Icon(IconBroken.Arrow___Down_Square),
              onPressed: onPressedArchive,
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
                shrinkWrap: false,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 5 / 4,
                  // crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemBuilder: (_, index) => InkWell(
                  onTap: () async {
                    await showImageViewer(
                      context,
                      CachedNetworkImageProvider(images[index]),
                      swipeDismissible: true,
                      doubleTapZoomable: true,
                      useSafeArea: true,
                    );
                  },
                  child: FancyShimmerImage(
                    imageUrl: images[index],
                    boxFit: BoxFit.cover,
                    shimmerBaseColor: Colors.grey,
                    shimmerHighlightColor: Colors.greenAccent,
                    shimmerBackColor: Colors.lightGreen,
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
