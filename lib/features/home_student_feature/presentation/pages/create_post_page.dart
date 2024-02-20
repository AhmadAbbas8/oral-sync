import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/custom_app_bar_action_button.dart';
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
          CustomAppBarActionButton(
            title: LocaleKeys.post,
            onTap: () => log('lol'),
          ),
          SizedBox(width: 5.w),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const CustomTextFormFieldCreatePost(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
