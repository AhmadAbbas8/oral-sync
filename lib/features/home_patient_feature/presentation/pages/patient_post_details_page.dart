import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/features/home_patient_feature/presentation/manager/free_paid_reservation_cubit/free_paid_reservation_cubit.dart';

import '../../../../core/utils/icon_broken.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../home_student_feature/presentation/widgets/no_task_widget.dart';
import '../../../home_student_feature/presentation/widgets/post_item_widget.dart';
import '../widgets/comment_form_field_patient.dart';

class PatientPostDetailsPage extends StatelessWidget {
  const PatientPostDetailsPage(
      {super.key, required this.cubit, required this.index,});

  static const routeName = '/patientPostDetailsPage';
  final FreePaidReservationCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.details).tr(),

        ),
        body: BlocBuilder<FreePaidReservationCubit, FreePaidReservationState>(
          builder: (context, state) {
            var cubit = context.read<FreePaidReservationCubit>();
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: PostItemWidget(
                    profileURL: 'http://graduationprt22-001-site1.gtempurl.com/Profile/default/male.png',
                    caption: cubit.freePosts[index].content ?? '',
                    commentsCount: cubit.freePosts[index].comments?.length ?? 0,
                    likesCount: cubit.freePosts[index].likeCount?.toInt() ?? 0,
                    postDate: cubit.freePosts[index].dateCreated ?? '',
                    images: cubit.freePosts[index].image ?? [],
                    userName:
                    cubit.freePosts[index].userName ?? '',
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(),
                ),
                cubit.freePosts[index].comments!.isNotEmpty
                    ? SliverList.builder(
                  itemBuilder: (context, innerIndex) =>
                      ListTile(
                        title: Text(
                            cubit.freePosts[index].comments![innerIndex].content ??
                                ''),
                        leading:  CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                          cubit.freePosts[index].comments![innerIndex].profileImage??'',
                          ),
                        ),
                        trailing: const Icon(IconBroken.Delete),
                      ),
                  itemCount: cubit.freePosts[index].comments?.length ?? 0,
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
