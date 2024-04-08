
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oralsync/features/home_patient_feature/presentation/manager/free_paid_reservation_cubit/free_paid_reservation_cubit.dart';

import '../../../../core/utils/colors_palette.dart';
import '../../../../core/utils/icon_broken.dart';
import '../../../../translations/locale_keys.g.dart';

class CommentFormFieldPatient extends StatelessWidget {
  const CommentFormFieldPatient({
    super.key,
    required this.cubit,
    required this.index, required this.state,
  });

  final FreePaidReservationCubit cubit;
  final int index;
  final FreePaidReservationState state;

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
          suffixIcon: state is !DoCommentPatientLoading
              ? IconButton(
            icon: const Icon(IconBroken.Send),
            onPressed: () => cubit.doComment(
                cubit.freePosts[index].postId?.toInt() ?? 0,
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