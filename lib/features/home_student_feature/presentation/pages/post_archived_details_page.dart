import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/comment_widget.dart';
import '../../../../translations/locale_keys.g.dart';
import '../manager/archived_post_cubit/archived_post_cubit.dart';
import '../widgets/comment_form_field.dart';
import '../widgets/no_task_widget.dart';
import '../widgets/post_item_widget.dart';

class PostArchivedDetailsPage extends StatelessWidget {
  const PostArchivedDetailsPage({
    super.key,
    required this.cubit,
    required this.index,
  });

  static const String routeName = '/PostArchivedDetailsPage';
  final ArchivedPostCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.details).tr(),
        ),
        body: BlocBuilder<ArchivedPostCubit, ArchivedPostState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: PostItemWidget(
                    profileURL: cubit.studentModel.profileImage ?? '',
                    caption: cubit.posts[index].content ?? '',
                    commentsCount: cubit.posts[index].comments?.length ?? 0,
                    likesCount: cubit.posts[index].likeCount?.toInt() ?? 0,
                    postDate: DateFormat("MMM dd, yyyy",'en').format(
                        DateFormat("yyyy/MM/dd",'en').parse(
                            cubit.posts[index].dateCreated ?? '2001/08/01')),
                    images: cubit.posts[index].postImages ?? [],
                    userName:
                    '${cubit.studentModel.userDetails?.firstName} ${cubit.studentModel.userDetails?.lastName}',
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(),
                ),
                cubit.posts[index].comments!.isNotEmpty
                    ? SliverList.builder(
                  itemBuilder: (context, index1) => CommentWidget(
                    comment: cubit.posts[index].comments![index1],
                  ),
                  itemCount: cubit.posts[index].comments?.length ?? 0,
                )
                    : const SliverToBoxAdapter(
                  child: NoTaskWidget(title: LocaleKeys.no_comments),
                ),
                // SliverToBoxAdapter(
                //   child: CommentFormField(
                //       cubit: cubit, index: index, state: state),
                // )
              ],
            );
          },
        ),
      ),
    );
  }
}


//
// class CommentArchivedFormField extends StatelessWidget {
//   const CommentArchivedFormField({
//     super.key,
//     required this.cubit,
//     required this.index, required this.state,
//   });
//
//   final ArchivedPostCubit cubit;
//   final int index;
//   final ArchivedPostState state;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//           vertical: 10.0, horizontal: 10),
//       child: TextFormField(
//         controller: cubit.commentController,
//         decoration: InputDecoration(
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           hintText: LocaleKeys.write_comment.tr(),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           suffixIcon: state is !DoCommentLoading
//               ? IconButton(
//             icon: const Icon(IconBroken.Send),
//             onPressed: () => cubit.doComment(
//                 cubit.posts[index].postId?.toInt() ?? 0,
//                 index),
//           )
//               : const FittedBox(
//             child: SpinKitDualRing(
//               color: ColorsPalette.buttonLoginColor,
//             ),
//           ),
//         ),
//         minLines: 1,
//         maxLines: 3,
//       ),
//     );
//   }
// }
