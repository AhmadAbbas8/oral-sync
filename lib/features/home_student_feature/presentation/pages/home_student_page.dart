import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';

import '../../../../core/helpers/check_language.dart';
import '../../../../core/helpers/snackbars.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/colors_palette.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../translations/locale_keys.g.dart';
import '../manager/home_student_cubit/home_student_cubit.dart';
import '../widgets/no_task_widget.dart';
import '../widgets/post_item_widget.dart';
import 'post_details_page.dart';

class HomeStudentPage extends StatelessWidget {
  static const routeName = '/homeStudentPage';

  const HomeStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeStudentCubit(
        getAllPostsStudentUseCase: ServiceLocator.instance(),
        doCommentUseCase: ServiceLocator.instance(),
        archiveAndUnArchivePostUseCase: ServiceLocator.instance(),
      )..getAllPosts(),
      child: Scaffold(
        body: BlocConsumer<HomeStudentCubit, HomeStudentState>(
          listener: (context, state) {
            _stateHandler(state, context);
          },
          buildWhen: (previous, current) => current != previous,
          listenWhen: (previous, current) => current != previous,
          builder: (context, state) {
            var cubit = context.read<HomeStudentCubit>();
            return RefreshIndicator(
              onRefresh: () async => cubit.getAllPosts(),
              child: Center(
                child: state is GetAllPostsLoading
                    ? const LoadingWidget()
                    : cubit.posts.isNotEmpty
                        ? ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                              endIndent: 20.w,
                              indent: 20.w,
                            ),
                            itemCount: cubit.posts.length,
                            // shrinkWrap: true,
                            itemBuilder: (_, index) => PostItemWidget(
                              profileURL: cubit.posts[index].profileImage ?? '',
                              caption: cubit.posts[index].content ?? '',
                              commentsCount:
                                  cubit.posts[index].comments?.length ?? 0,
                              likesCount:
                                  cubit.posts[index].likeCount?.toInt() ?? 0,
                              onTaComment: () => context.pushNamed(
                                PostDetailsPage.routeName,
                                arguments: [cubit, index],
                              ),
                              postDate: DateFormat("MMM dd, yyyy").format(
                                  DateFormat("yyyy/MM/dd").parse(
                                      cubit.posts[index].dateCreated ??
                                          '2001/08/01')),
                              images: cubit.posts[index].postImages ?? [],
                              onPressedArchive: () =>
                                  cubit.archiveAndUnArchivePost(
                                      cubit.posts[index].postId ?? 0),
                              userName:
                                  '${cubit.studentModel.userDetails?.firstName} ${cubit.studentModel.userDetails?.lastName}',
                            ),
                          )
                        : const NoTaskWidget(title: LocaleKeys.no_tasks),
              ),
            );
          },
        ),
      ),
    );
  }

  void _stateHandler(HomeStudentState state, BuildContext context) {
    if (state is GetAllPostsError) {
      showCustomSnackBar(
        context,
        msg: isArabic(context)
            ? state.responseModel?.messageAr ?? ''
            : state.responseModel?.messageEn ?? '',
        backgroundColor: ColorsPalette.errorColor,
      );
    }
    if (state is ArchiveUnArchivePostSuccess) {
      showCustomSnackBar(
        context,
        msg: isArabic(context)
            ? state.model.messageAr ?? ''
            : state.model.messageEn ?? '',
        backgroundColor: ColorsPalette.successColor,
      );
    }
    if (state is ArchiveUnArchivePostError) {
      showCustomSnackBar(
        context,
        msg: isArabic(context)
            ? state.model.messageAr ?? ''
            : state.model.messageEn ?? '',
        backgroundColor: ColorsPalette.successColor,
      );
    }
  }
}
