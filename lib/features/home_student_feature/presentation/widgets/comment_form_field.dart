
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/utils/colors_palette.dart';
import '../../../../core/utils/icon_broken.dart';
import '../../../../translations/locale_keys.g.dart';
import '../manager/home_student_cubit/home_student_cubit.dart';

class CommentFormField extends StatelessWidget {
  const CommentFormField({
    super.key,
    required this.cubit,
    required this.index, required this.state,
  });

  final HomeStudentCubit cubit;
  final int index;
  final HomeStudentState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 10.0, horizontal: 10),
      child: TextFormField(
        controller: cubit.commentController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: LocaleKeys.write_comment.tr(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: state is !DoCommentLoading
              ? IconButton(
            icon: const Icon(IconBroken.Send),
            onPressed: () => cubit.doComment(
                cubit.posts[index].postId?.toInt() ?? 0,
                index),
          )
              : const FittedBox(
            child: SpinKitDualRing(
              color: ColorsPalette.buttonLoginColor,
            ),
          ),
        ),
        minLines: 1,
        maxLines: 3,
      ),
    );
  }
}
