import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/cache_helper/shared_prefs_keys.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/core/utils/size_helper.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';
import 'package:oralsync/features/home_patient_feature/presentation/manager/free_paid_reservation_cubit/free_paid_reservation_cubit.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/like_comment_widget.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

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
    this.userId,
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
  final String? userId;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    String user = ServiceLocator.instance<CacheStorage>()
        .getData(key: SharedPrefsKeys.user);
    var userModel = UserModel.fromJson(json.decode(user));
    var role = userModel.userRole?.toUpperCase() ?? '';
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
            title: role == 'Patient'.toUpperCase()
                ? BlocBuilder<FreePaidReservationCubit,
                    FreePaidReservationState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () => context
                            .read<FreePaidReservationCubit>()
                            .getUserData(userId!),
                        child: Text(
                          userName,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      );
                    },
                  )
                : Text(
                    userName,
                    style: const TextStyle(fontWeight: FontWeight.w500),
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
                    errorWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                        ),
                        const Text(LocaleKeys.error).tr(),
                      ],
                    ),
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
