import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oralsync/core/helpers/check_language.dart';
import 'package:oralsync/core/helpers/custom_progress_indicator.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/helpers/snackbars.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/core/widgets/info_widget.dart';
import 'package:oralsync/features/home_patient_feature/data/models/DoctorModel.dart';
import 'package:oralsync/features/rating_feature/presentation/pages/rating_page.dart';

import '../../../../core/widgets/custom_rating_bar_widget.dart';
import '../../../../translations/locale_keys.g.dart';
import '../manager/profile_view_from_patient_cubit.dart';
import '../widgets/custom_profile_button_widgets.dart';

class DoctorProfilePatientViewPage extends StatelessWidget {
  const DoctorProfilePatientViewPage({super.key, required this.doctorModel});

  static const routeName = '/DoctorProfilePatientViewPage';
  final DoctorModel doctorModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ServiceLocator.instance<ProfileViewFromPatientCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.profile).tr(),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Hero(
                tag: doctorModel.doctor?.doctorId ?? 0,
                child: ClipOval(
                  child: FancyShimmerImage(
                    imageUrl: doctorModel.profileImage ?? '',
                    width: 100.w,
                    errorWidget: Image.asset('assets/test/message_iamage.png'),
                    boxFit: BoxFit.contain,
                  ),
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
                              doctorId: doctorModel.doctor?.userId ?? '',
                              location: doctorModel.doctor?.governorate ?? '',
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
                  title: doctorModel.name ?? '',
                  icon: IconBroken.User,
                ),
                InfoWidget(
                  title: doctorModel.doctor?.email ?? '',
                  icon: IconBroken.Message,
                ),
                InfoWidget(
                  title: doctorModel.doctor?.phoneNumber ?? '',
                  icon: IconBroken.Call,
                ),
                InfoWidget(
                  title: doctorModel.doctor?.isMale ?? true ? 'Male' : 'Female',
                  icon: doctorModel.doctor?.isMale ?? true
                      ? FontAwesomeIcons.male
                      : FontAwesomeIcons.female,
                ),
                InfoWidget(
                  title: doctorModel.doctor?.birthDate ?? '',
                  icon: IconBroken.Calendar,
                ),
                InfoWidget(
                  title: doctorModel.doctor?.universityName ?? '',
                  icon: FontAwesomeIcons.buildingColumns,
                ),
                InfoWidget(
                  title: doctorModel.doctor!.clinicAddresses
                      .toString()
                      .replaceAll(']', '')
                      .replaceAll('[', ''),
                  icon: IconBroken.Home,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Wrap(
                    children: doctorModel.doctor?.insuranceCompanies
                            ?.map<Chip>(
                              (element) => Chip(
                                label: Text(
                                  element ?? '',
                                ),
                                backgroundColor: Colors.blue[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            )
                            .toList() ??
                        [],
                  ),
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
                    rating: doctorModel.averageRate?.toDouble() ?? 0.0,
                    onTap: () => context
                        .read<ProfileViewFromPatientCubit>()
                        .getAllRates(doctorModel.doctor?.userId ?? ''),
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
