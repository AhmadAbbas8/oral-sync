import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/core/utils/icon_broken.dart';

class ImageProfileWidget extends StatelessWidget {
  const ImageProfileWidget({
    super.key,
    required this.imageProfile,
    this.onPressed,
  });

  final String imageProfile;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    log('----------------------------------------------------$imageProfile');
    return Stack(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            imageProfile,
            headers: const {'Cache-Control': 'no-cache'},
          ),
          maxRadius: 50,
        ),
        Positioned(
          top: 65,
          left: 60,
          child: IconButton(
            onPressed: onPressed,
            icon: const Icon(
              IconBroken.Camera,
              color: ColorsPalette.buttonLoginColor,
            ),
          ),
        ),
      ],
    );
  }
}
