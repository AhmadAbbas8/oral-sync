import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/custom_button_photo.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/custom_text_form_field_create_post.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

class CreatePostPage extends StatefulWidget {
  static const routeName = '/createPostPage';

  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  List<XFile>? images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          LocaleKeys.patient_request,
        ).tr(),
        actions: [
          MaterialButton(
            color: ColorsPalette.buttonLoginColor,
            height: 45,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onPressed: () => log('message'),
            child: Text(
              LocaleKeys.post,
              style: AppStyles.styleSize28
                  .copyWith(fontSize: 20, color: Colors.white),
            ).tr(),
          ),
          SizedBox(width: 5.w),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            CustomTextFormFieldCreatePost(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
              child: CustomButtonPhoto(
                onTap: () async {
                  final ImagePicker picker =
                      ServiceLocator.instance<ImagePicker>();

                  var imagesPicked = await picker.pickMultiImage();
                  setState(() {
                    images = imagesPicked;
                  });
                },
              ),
            ),
            if (images != null)
              Expanded(
                child: GridView.builder(
                  itemCount: images!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) => Image.file(
                    File(
                      images![index].path,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
