import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';

import '../../../../core/helpers/check_language.dart';
import '../../../../core/helpers/custom_progress_indicator.dart';
import '../../../../core/helpers/snackbars.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/colors_palette.dart';
import '../../../../core/utils/icon_broken.dart';
import '../../../../core/widgets/custom_rating_bar_widget.dart';
import '../../../../core/widgets/info_widget.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../Auth/data/models/user_model.dart';
import '../../../rating_feature/presentation/pages/rating_page.dart';
import '../manager/profile_view_from_patient_cubit.dart';
import '../widgets/custom_profile_button_widgets.dart';

class StudentProfilePatientViewPage extends StatelessWidget {
  const StudentProfilePatientViewPage({
    super.key,
    required this.user,
    required this.userId,
  });

  static const routeName = '/StudentProfilePatientViewPage';

  final UserModel user;
  final String userId;

  @override
  Widget build(BuildContext context) {
    var student = user.userDetails as StudentDetails;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          LocaleKeys.profile,
        ).tr(),
      ),
      body: BlocProvider(
        create: (context) =>
            ServiceLocator.instance<ProfileViewFromPatientCubit>(),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ClipOval(
                child: FancyShimmerImage(
                  imageUrl: user.profileImage ?? '',
                  // imageUrl:
                  //     'http://graduationprt24-001-site1.jtempurl.com/Profile/b34fbe6f-9b21-4916-9814-88023bae5077/b34fbe6f-9b21-4916-9814-88023bae5077.png',
                  width: 100.w,
                  errorWidget: Image.asset('assets/test/message_iamage.png'),
                  boxFit: BoxFit.contain,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 10.h),
            ),
            SliverToBoxAdapter(
              child: BlocConsumer<ProfileViewFromPatientCubit,
                  ProfileViewFromPatientState>(
                listener: (context, state) {
                  if (state is CreateReserveLoading) {
                    showCustomProgressIndicator(context);
                  } else if (state is CreateReserveError) {
                    context.pop();
                    showCustomSnackBar(
                      context,
                      msg: isArabic(context)
                          ? state.responseModel.messageAr ?? ''
                          : state.responseModel.messageEn ?? '',
                      backgroundColor: ColorsPalette.errorColor,
                    );
                  } else if (state is CreateReserveSuccess) {
                    context.pop();
                    showCustomSnackBar(
                      context,
                      msg: isArabic(context)
                          ? state.responseModel.messageAr ?? ''
                          : state.responseModel.messageEn ?? '',
                      backgroundColor: ColorsPalette.successColor,
                    );
                  }
                },
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomProfileButtonWidget(
                        title: LocaleKeys.message,
                        icon: IconBroken.Message,
                        onPressed: () {},
                      ),
                      CustomProfileButtonWidget(
                        title: LocaleKeys.reserve,
                        icon: IconBroken.Star,
                        onPressed: () => context
                            .read<ProfileViewFromPatientCubit>()
                            .createReserve(
                              doctorId: userId,
                              location: user.userDetails?.governorate ?? '',
                            ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(
                thickness: 2,
                endIndent: 15,
                indent: 15,
              ),
            ),
            SliverList.list(
              children: [
                InfoWidget(
                  title:
                      '${user.userDetails?.firstName} ${user.userDetails?.lastName}',
                  icon: IconBroken.User,
                ),
                InfoWidget(
                  title: user.userDetails?.email ?? '',
                  icon: IconBroken.Message,
                ),
                InfoWidget(
                  title: user.userDetails?.phoneNumber ?? '',
                  icon: IconBroken.Call,
                ),
                InfoWidget(
                  title: user.userDetails?.isMale ?? true ? 'Male' : 'Female',
                  icon: user.userDetails?.isMale ?? true
                      ? FontAwesomeIcons.male
                      : FontAwesomeIcons.female,
                ),
                InfoWidget(
                  title: user.userDetails?.birthDate ?? '',
                  icon: IconBroken.Calendar,
                ),
                InfoWidget(
                  title: student.universityName ?? '',
                  icon: FontAwesomeIcons.buildingColumns,
                ),
                InfoWidget(
                  title: student.universityAddress
                      .toString()
                      .replaceAll(']', '')
                      .replaceAll('[', ''),
                  icon: IconBroken.Home,
                ),
                BlocConsumer<ProfileViewFromPatientCubit,
                    ProfileViewFromPatientState>(
                  listener: (context, state) {
                    if (state is GetAllRatesLoading) {
                      showCustomProgressIndicator(context);
                    } else if (state is GetAllRatesError) {
                      context.pop();
                      showCustomSnackBar(
                        context,
                        msg: isArabic(context)
                            ? state.model.messageAr ?? ''
                            : state.model.messageEn ?? '',
                        backgroundColor: ColorsPalette.errorColor,
                      );
                    } else if (state is GetAllRatesSuccess) {
                      context.pop();
                      context.pushNamed(RatingPage.routeName,
                          arguments: state.rates);
                    }
                  },
                  builder: (context, state) => CustomRatingBarWidget(
                    rating:user.averageRate?.toDouble()??0.0 ,

                    ///TODO : rate here
                    onTap: () => context
                        .read<ProfileViewFromPatientCubit>()
                        .getAllRates(userId),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
