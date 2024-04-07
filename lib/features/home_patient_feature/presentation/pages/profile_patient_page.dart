import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/helpers/check_language.dart';
import 'package:oralsync/core/helpers/custom_progress_indicator.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/helpers/snackbars.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/features/home_patient_feature/presentation/manager/patient_profile_cubit/patient_profile_cubit.dart';

import '../../../../core/widgets/circle_avatar.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../home_student_feature/presentation/pages/edit_profile_page.dart';
import '../../../home_student_feature/presentation/widgets/custom_app_bar_action_button.dart';

class ProfilePatientPage extends StatelessWidget {
  const ProfilePatientPage({super.key});

  static const routeName = '/profilePatientPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.profile).tr(),
        actions: [
          CustomAppBarActionButton(
            title: LocaleKeys.edit,
            onTap: () => log('messagemessage'),
          ),
          SizedBox(width: 5.w)
        ],
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => PatientProfileCubit(
            ServiceLocator.instance(),
            ServiceLocator.instance(),
          ),
          child: BlocConsumer<PatientProfileCubit, PatientProfileState>(
            listener: (context, state) {
              stateHandler(state, context);
            },
            builder: (context, state) {
              var cubit = context.read<PatientProfileCubit>();
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageProfileWidget(
                    onPressed: () async => await cubit.changeProfileImage(),
                    imageProfile: cubit.getUserModel().profileImage ?? '',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void stateHandler(PatientProfileState state, BuildContext context) {
    if (state is ChangePatientProfileLoading) {
      showCustomProgressIndicator(context);
    }
    if (state is ChangePatientProfileError) {
      context.pop();
      showCustomSnackBar(
        context,
        msg: isArabic(context)
            ? state.error?.messageAr ?? ''
            : state.error?.messageEn ?? '',
        backgroundColor: ColorsPalette.errorColor,
      );
    }
    if (state is ChangePatientProfileSuccess) {
      context.pop();
      showCustomSnackBar(context,
          msg: LocaleKeys.image_profile_changed_successfully.tr(),
          backgroundColor: ColorsPalette.successColor);
    }
  }
}
