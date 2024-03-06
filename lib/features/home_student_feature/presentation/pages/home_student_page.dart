import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:oralsync/core/helpers/snackbars.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/features/home_student_feature/presentation/manager/home_student_cubit/home_student_cubit.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/no_task_widget.dart';
import '../../../../core/helpers/check_language.dart';
import '../../../../core/utils/colors_palette.dart';
import '../../../../translations/locale_keys.g.dart';
import '../widgets/post_item_widget.dart';

class HomeStudentPage extends StatelessWidget {
  static const routeName = '/homeStudentPage';

  const HomeStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeStudentCubit(getAllPostsStudentUseCase: ServiceLocator.instance())
            ..getAllPosts(),
      child: Scaffold(
        body: BlocConsumer<HomeStudentCubit, HomeStudentState>(
          listener: (context, state) {
            if (state is GetAllPostsError) {
              showCustomSnackBar(
                context,
                msg: isArabic(context)
                    ? state.responseModel?.messageAr ?? ''
                    : state.responseModel?.messageEn ?? '',
                backgroundColor: ColorsPalette.errorColor,
              );
            }
          },
          buildWhen: (previous, current) => current != previous,
          listenWhen: (previous, current) => current != previous,
          builder: (context, state) {
            var cubit = context.read<HomeStudentCubit>();
            return RefreshIndicator(
              onRefresh: () async => cubit.getAllPosts(),
              child: Center(
                child: state is GetAllPostsLoading
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
                            itemBuilder: (context, index) => PostItemWidget(
                              profileURL: cubit.studentModel.profileImage ?? '',
                              caption: cubit.posts[index].content ?? '',
                              commentsCount:  cubit.posts[index].comments?.length??0,
                              likesCount: cubit.posts[index].likeCount?.toInt()??0,
                              postDate: DateFormat("MMM dd, yyyy").format(
                                  DateFormat("yyyy/MM/dd").parse(
                                      cubit.posts[index].dateCreated ??
                                          '2001/08/01')),
                              images: cubit.posts[index].image ?? [],
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
}
