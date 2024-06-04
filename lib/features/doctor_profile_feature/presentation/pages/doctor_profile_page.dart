import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';
import 'package:oralsync/features/doctor_profile_feature/presentation/manager/doctor_profile_cubit/doctor_profile_cubit.dart';
import '../../../../core/helpers/check_language.dart';
import '../../../../core/helpers/custom_progress_indicator.dart';
import '../../../../core/helpers/snackbars.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/colors_palette.dart';
import '../../../../core/utils/icon_broken.dart';
import '../../../../core/widgets/circle_avatar.dart';
import '../../../../core/widgets/info_widget.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../home_student_feature/presentation/widgets/custom_app_bar_action_button.dart';
import 'edit_profile_doctor_page.dart';

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({super.key});

  static const String routeName = '/DoctorProfilePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => ServiceLocator.instance<DoctorProfileCubit>(),
          child: BlocConsumer<DoctorProfileCubit, DoctorProfileState>(
            listener: (context, state) {
              stateHandler(state, context);
            },
            builder: (context, state) {
              var cubit = context.read<DoctorProfileCubit>();
              var userData = cubit.getUserModel().userDetails as DoctorDetails;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageProfileWidget(
                    onPressed: () async => await cubit.changeProfileImage(),
                    imageProfile: cubit.getUserModel().profileImage ?? '',
                  ),
                  InfoWidget(
                    title:
                        '${userData.firstName ?? ''} ${userData.lastName ?? ''}',
                    icon: IconBroken.User,
                  ),
                  InfoWidget(
                    title: userData.email ?? '',
                    icon: IconBroken.Message,
                  ),
                  InfoWidget(
                    title: userData.phoneNumber ?? '',
                    icon: IconBroken.Call,
                  ),
                  InfoWidget(
                    title: userData.isMale ?? true ? 'Male' : 'Female',
                    icon: userData.isMale ?? true
                        ? FontAwesomeIcons.male
                        : FontAwesomeIcons.female,
                  ),
                  InfoWidget(
                    title: userData.birthDate ?? '',
                    icon: IconBroken.Calendar,
                  ),
                  InfoWidget(
                    title: userData.universityName ?? '',
                    icon: FontAwesomeIcons.buildingColumns,
                  ),
                  InfoWidget(
                    title: userData.clinicAddress
                        .toString()
                        .replaceAll(']', '')
                        .replaceAll('[', ''),
                    icon: IconBroken.Home,
                  ),
                  Wrap(
                    children: userData.insuranceCompanies
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
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) => AppBar(
        title: const Text(LocaleKeys.profile).tr(),
        actions: [
          CustomAppBarActionButton(
            title: LocaleKeys.edit,
            onTap: () => context.pushNamed(EditProfileDoctorPage.routeName),
          ),
          SizedBox(width: 5.w)
        ],
      );

  void stateHandler(DoctorProfileState state, BuildContext context) {
    if (state is ChangeDoctorProfileLoading) {
      showCustomProgressIndicator(context);
    }
    if (state is ChangeDoctorProfileError) {
      context.pop();
      showCustomSnackBar(
        context,
        msg: isArabic(context)
            ? state.model?.messageAr ?? ''
            : state.model?.messageEn ?? '',
        backgroundColor: ColorsPalette.errorColor,
      );
    }
    if (state is ChangeDoctorProfileSuccess) {
      context.pop();
      showCustomSnackBar(context,
          msg: LocaleKeys.image_profile_changed_successfully.tr(),
          backgroundColor: ColorsPalette.successColor);
    }
  }
}
