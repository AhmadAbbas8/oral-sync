import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/helpers/check_language.dart';
import 'package:oralsync/core/helpers/custom_progress_indicator.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/helpers/snackbars.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/student_home_layout_page.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/custom_app_bar_action_button.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/custom_button_photo.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/custom_text_form_field_create_post.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../manager/student_post_cubit/student_post_cubit.dart';

class CreatePostPage extends StatelessWidget {
  static const routeName = '/createPostPage';

  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentPostCubit(
        createPostUseCase: ServiceLocator.instance(),
      ),
      child: BlocConsumer<StudentPostCubit, StudentPostState>(
        listener: (context, state) {
          if (state is CreatePostLoading) {
            showCustomProgressIndicator(context);
          } else if (state is CreatePostError) {
            context.pop();
            showCustomSnackBar(
              context,
              msg: isArabic(context)
                  ? state.responseModel?.messageAr ?? ''
                  : state.responseModel?.messageEn ?? '',
              backgroundColor: ColorsPalette.errorColor,
            );
          } else if (state is CreatePostSuccess) {
            showCustomSnackBar(
              context,
              msg: isArabic(context)
                  ? state.model.messageAr ?? ''
                  : state.model.messageEn ?? '',
              backgroundColor: ColorsPalette.successColor,
            );
            context.pushNamedAndRemoveUntil(
              HomeStudentLayoutPage.routeName,
              predicate: (route) => false,
            );
          }
        },
        builder: (context, state) {
          var cubit = context.read<StudentPostCubit>();
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                LocaleKeys.patient_request,
              ).tr(),
              actions: [
                CustomAppBarActionButton(
                  title: LocaleKeys.post,
                  onTap: () {
                    if (cubit.captionController.text.isEmpty) {
                      showCustomSnackBar(
                        context,
                        msg: LocaleKeys.describe_your_request_in_details.tr(),
                        backgroundColor: Colors.red,
                      );
                    } else {
                      cubit.createPost();
                    }
                  },
                ),
                SizedBox(width: 5.w),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  CustomTextFormFieldCreatePost(
                    textEditingController: cubit.captionController,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                    child: CustomButtonPhoto(
                      onTap: () => cubit.pickImages(),
                    ),
                  ),
                  if (cubit.pickedImages.isNotEmpty)
                    Expanded(
                      child: GridView.builder(
                        itemCount: cubit.pickedImages.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) => Image.file(
                          File(
                            cubit.pickedImages[index].path,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
