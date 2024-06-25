import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/post_archived_details_page.dart';

import '../../../../core/helpers/check_language.dart';
import '../../../../core/helpers/snackbars.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/colors_palette.dart';
import '../../../../translations/locale_keys.g.dart';
import '../manager/archived_post_cubit/archived_post_cubit.dart';
import '../widgets/no_task_widget.dart';
import '../widgets/post_item_widget.dart';

class ArchiveStudentPage extends StatelessWidget {
  const ArchiveStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArchivedPostCubit(
        postsArchivedUseCase: ServiceLocator.instance(),
       archiveAndUnArchivePostUseCase: ServiceLocator.instance(), 
      )..getAllPostsArchived(),
      child: Scaffold(
        body: BlocConsumer<ArchivedPostCubit, ArchivedPostState>(
          listener: (context, state) {
            _stateHandler(state, context);
          },
          buildWhen: (previous, current) => current != previous,
          listenWhen: (previous, current) => current != previous,
          builder: (context, state) {
            var cubit = context.read<ArchivedPostCubit>();
            return RefreshIndicator(
              onRefresh: () async => cubit.getAllPostsArchived(),
              child: Center(
                child: state is GetAllArchivedPostsLoading
                    ? const SpinKitDoubleBounce(
                        color: Colors.green,
                        size: 200,
                      )
                    : cubit.posts.isNotEmpty
                        ? ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                              endIndent: 20.w,
                              indent: 20.w,
                            ),
                            itemCount: cubit.posts.length,
                            itemBuilder: (_, index) => PostItemWidget(
                              profileURL: cubit.studentModel.profileImage ?? '',
                              caption: cubit.posts[index].content ?? '',
                              commentsCount:
                                  cubit.posts[index].comments?.length ?? 0,
                              likesCount:
                                  cubit.posts[index].likeCount?.toInt() ?? 0,
                              onTaComment: () => context.pushNamed(
                                PostArchivedDetailsPage.routeName,
                                arguments: [cubit, index],
                              ),
                              postDate: DateFormat("MMM dd, yyyy",'en').format(
                                  DateFormat("yyyy/MM/dd",'en').parse(
                                      cubit.posts[index].dateCreated ??
                                          '2001/08/01')),
                              images: cubit.posts[index].postImages ?? [],
                              onPressedArchive:() =>  cubit.archiveAndUnArchivePost(cubit.posts[index].postId??0),
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

  void _stateHandler(ArchivedPostState state, BuildContext context) {

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
    if (state is GetAllArchivedPostsError) {
      showCustomSnackBar(
        context,
        msg: isArabic(context)
            ? state.model.messageAr ?? ''
            : state.model.messageEn ?? '',
        backgroundColor: ColorsPalette.errorColor,
      );
    }
  }

}
