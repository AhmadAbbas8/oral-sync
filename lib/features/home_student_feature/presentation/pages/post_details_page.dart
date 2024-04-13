import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/no_task_widget.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/post_item_widget.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../manager/home_student_cubit/home_student_cubit.dart';
import '../widgets/comment_form_field.dart';

class PostDetailsPage extends StatelessWidget {
  const PostDetailsPage({super.key, required this.cubit, required this.index});

  static const String routeName = '/PostDetailsPage';
final HomeStudentCubit cubit;
final int index;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.details).tr(),
        ),
        body: BlocBuilder<HomeStudentCubit, HomeStudentState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: PostItemWidget(
                    profileURL: cubit.studentModel.profileImage ?? '',
                    caption: cubit.posts[index].content ?? '',
                    commentsCount: cubit.posts[index].comments?.length ?? 0,
                    likesCount: cubit.posts[index].likeCount?.toInt() ?? 0,
                    postDate: DateFormat("MMM dd, yyyy").format(
                        DateFormat("yyyy/MM/dd").parse(
                            cubit.posts[index].dateCreated ?? '2001/08/01')),
                    images: cubit.posts[index].image ?? [],
                    userName:
                        '${cubit.studentModel.userDetails?.firstName} ${cubit.studentModel.userDetails?.lastName}',
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(),
                ),
                cubit.posts[index].comments!.isNotEmpty
                    ? SliverList.builder(
                        itemBuilder: (context, index1) => ListTile(
                          title: Text(
                              cubit.posts[index].comments![index1].content ??
                                  ''),
                          leading:  CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              cubit.posts[index].comments![index1].profileImage??'',
                            ),
                          ),
                          trailing: const Icon(IconBroken.Delete),
                        ),
                        itemCount: cubit.posts[index].comments?.length ?? 0,
                      )
                    : const SliverToBoxAdapter(
                        child: NoTaskWidget(title: LocaleKeys.no_comments),
                      ),
                SliverToBoxAdapter(
                  child: CommentFormField(
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
