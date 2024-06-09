import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/features/home_patient_feature/presentation/manager/patient_profile_cubit/patient_profile_cubit.dart';

import '../../../../core/helpers/check_language.dart';
import '../../../../core/helpers/custom_progress_indicator.dart';
import '../../../../core/helpers/general_validators.dart';
import '../../../../core/helpers/snackbars.dart';
import '../../../../core/utils/colors_palette.dart';
import '../../../../core/utils/size_helper.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_alert_dialog_governorate.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../Auth/presentation/widgets/custom_login_button_widget.dart';
import '../../../Auth/presentation/widgets/custom_text_form_field_login.dart';
import '../../../Auth/presentation/widgets/custom_tow_form_field_widget.dart';

class EditProfilePatientPage extends StatelessWidget {
  const EditProfilePatientPage({super.key});

  static const routeName = '/editProfilePatientPage';

  @override
  Widget build(BuildContext context) {
    const List type = ['male', 'female'];
    var size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => PatientProfileCubit(
        ServiceLocator.instance(),
        ServiceLocator.instance(),
      )..onOpenEditPage(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.edit_data).tr(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: size.height),
              child: IntrinsicHeight(
                child: BlocConsumer<PatientProfileCubit, PatientProfileState>(
                  listener: (context, state) {
                    if (state is UpdatePatientDataLoading) {
                      showCustomProgressIndicator(context);
                    } else if (state is UpdatePatientDataError) {
                      context.pop();
                      showCustomSnackBar(
                        context,
                        msg: isArabic(context)
                            ? state.responseModel?.messageAr ?? ''
                            : state.responseModel?.messageEn ?? '',
                        backgroundColor: ColorsPalette.errorColor,
                      );
                    } else if (state is UpdatePatientDataSuccess) {
                      context.pop();
                      context.pop();
                      showCustomSnackBar(
                        context,
                        msg: 'updated_successfully'.tr(),
                        backgroundColor: ColorsPalette.successColor,
                      );
                    }
                  },
                  builder: (context, state) {
                    var cubit = context.read<PatientProfileCubit>();
                    return Form(
                      key: cubit.formKey,
                      child: Column(
                        children: [
                          CustomTwoFormFieldWidget(
                            fTitle: LocaleKeys.first_name,
                            sTitle: LocaleKeys.last_name,
                            validator1: generalValidator,
                            validator2: generalValidator,
                            textEditingController1: cubit.fNameController,
                            textEditingController2: cubit.lNameController,
                          ),
                          SizeHelper.defSizedBoxField,
                          CustomTextFormFieldLogin(
                            width: size.width * .8,
                            textInputType: TextInputType.emailAddress,
                            hintText: LocaleKeys.email,
                            validator: validateEmail,
                            textEditingController: cubit.emailController,
                          ),
                          SizeHelper.defSizedBoxField,
                          CustomTextFormFieldLogin(
                            width: size.width * .8,
                            textInputType: TextInputType.phone,
                            hintText: LocaleKeys.phone_number,
                            validator: generalValidator,
                            textEditingController: cubit.phoneController,
                          ),
                          SizeHelper.defSizedBoxField,
                          CustomTextFormFieldLogin(
                            width: size.width * .8,
                            textInputType: TextInputType.datetime,
                            readOnly: true,
                            textEditingController: cubit.dateOfBirthController,
                            onTap: () => cubit.onTapBirthDate(context),
                            hintText: LocaleKeys.date_of_birth,
                          ),
                          SizeHelper.defSizedBoxField,
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleKeys.gender,
                                  style: AppStyles.styleSize14.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ).tr(),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: RadioListTile<bool>.adaptive(
                                        value: true,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        groupValue: cubit.isMale,
                                        title: Text(
                                          type[0],
                                          style: const TextStyle(fontSize: 14),
                                        ).tr(),
                                        onChanged: (value) =>
                                            cubit.onChangedGender(value),
                                        // onChanged: null,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: RadioListTile<bool>.adaptive(
                                        value: false,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        groupValue: cubit.isMale,
                                        title: Text(
                                          type[1],
                                          style: const TextStyle(fontSize: 14),
                                        ).tr(),
                                        onChanged: (value) =>
                                            cubit.onChangedGender(value),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizeHelper.defSizedBoxField,
                          CustomTwoFormFieldWidget(
                            fTitle: LocaleKeys.governorate,
                            sTitle: LocaleKeys.city,
                            textEditingController2: cubit.cityController,
                            textEditingController1: cubit.governorateController,
                            readOnly1: true,
                            onTap1: () async {
                              var selectedGover =
                                  await showGovernorateDialog(context);
                              cubit.governorateController.text =
                                  selectedGover ?? '';
                            },
                          ),
                          SizeHelper.defSizedBoxField,
                          FittedBox(
                            child: CustomLoginButtonWidget(
                              title: LocaleKeys.save,
                              minWidth: size.width * .8,
                              onPressed: () {
                                if (cubit.formKey.currentState!.validate()) {
                                  cubit.updateStudentData();
                                } else {
                                  showCustomSnackBar(context,
                                      msg: LocaleKeys
                                          .please_complete_required_data_firstly
                                          .tr(),
                                      backgroundColor:
                                          ColorsPalette.warningColor);
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
