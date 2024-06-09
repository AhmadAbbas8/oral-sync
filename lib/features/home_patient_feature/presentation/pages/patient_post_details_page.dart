import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/features/home_patient_feature/presentation/manager/free_paid_reservation_cubit/free_paid_reservation_cubit.dart';

import '../../../../core/widgets/comment_widget.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../home_student_feature/data/models/Student_post_model.dart';
import '../../../home_student_feature/presentation/widgets/no_task_widget.dart';
import '../../../home_student_feature/presentation/widgets/post_item_widget.dart';
import '../widgets/comment_form_field_patient.dart';

class PatientPostDetailsPage extends StatelessWidget {
  const PatientPostDetailsPage({
    super.key,
    required this.index,
    required this.studentPostModel,
  });

  static const routeName = '/patientPostDetailsPage';

  final int index;
  final StudentPostModel studentPostModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ServiceLocator.instance<FreePaidReservationCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.details).tr(),
        ),
        body: BlocBuilder<FreePaidReservationCubit, FreePaidReservationState>(
          builder: (context, state) {
            var cubit = ServiceLocator.instance<FreePaidReservationCubit>();
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: PostItemWidget(
                    userId: studentPostModel.userId,
                    profileURL: studentPostModel.profileImage ?? '',
                    caption: studentPostModel.content ?? '',
                    commentsCount: studentPostModel.comments?.length ?? 0,
                    likesCount: studentPostModel.likeCount?.toInt() ?? 0,
                    postDate: studentPostModel.dateCreated ?? '',
                    images: studentPostModel.postImages ?? [],
                    userName: studentPostModel.userName ?? '',
                    onTaLike: () => cubit.likeUnLike(
                        studentPostModel.postId?.toInt() ?? 0, index),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(),
                ),
                studentPostModel.comments!.isNotEmpty
                    ? SliverList.builder(
                        itemBuilder: (context, innerIndex) => CommentWidget(
                          comment: studentPostModel.comments![innerIndex],
                        ),
                        itemCount: studentPostModel.comments?.length ?? 0,
                      )
                    : const SliverToBoxAdapter(
                        child: NoTaskWidget(title: LocaleKeys.no_comments),
                      ),
                SliverToBoxAdapter(
                  child: CommentFormFieldPatient(
                      cubit: cubit, index: index, state: state),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
