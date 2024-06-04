import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/features/doctor_profile_feature/presentation/manager/doctor_profile_cubit/doctor_profile_cubit.dart';

import '../../../../core/helpers/check_language.dart';
import '../../../../core/helpers/custom_progress_indicator.dart';
import '../../../../core/helpers/general_validators.dart';
import '../../../../core/helpers/snackbars.dart';
import '../../../../core/utils/colors_palette.dart';
import '../../../../core/utils/size_helper.dart';
import '../../../../core/utils/styles.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../Auth/presentation/widgets/custom_login_button_widget.dart';
import '../../../Auth/presentation/widgets/custom_text_form_field_login.dart';
import '../../../Auth/presentation/widgets/custom_tow_form_field_widget.dart';
import '../../../Auth/presentation/widgets/multi_input_form_field.dart';

class EditProfileDoctorPage extends StatelessWidget {
  const EditProfileDoctorPage({super.key});

  static const String routeName = '/EditProfileDoctorPage';

  @override
  Widget build(BuildContext context) {
    const List type = ['male', 'female'];
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.edit_data).tr(),
      ),
      body: BlocProvider(
        create: (_) => ServiceLocator.instance<DoctorProfileCubit>()..onOpenEditPage(),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.height),
            child: IntrinsicHeight(
              child: BlocConsumer<DoctorProfileCubit, DoctorProfileState>(
                listener: (context, state) {
                  if (state is UpdateDoctorDataLoading) {
                    showCustomProgressIndicator(context);
                  }
                  else if (state is UpdateDoctorDataError) {
                    context.pop();
                    showCustomSnackBar(
                      context,
                      msg: isArabic(context)
                          ? state.responseModel?.messageAr ?? ''
                          : state.responseModel?.messageEn ?? '',
                      backgroundColor: ColorsPalette.errorColor,
                    );
                  }
                  else if (state is UpdateDoctorDataSuccess) {
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
                  var cubit = context.read<DoctorProfileCubit>();
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
                          textEditingController2: cubit.sNameController,
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
                          textInputType: TextInputType.text,
                          hintText: LocaleKeys.university_name,
                          validator: generalValidator,
                          textEditingController:
                          cubit.universityNameController,
                        ),
                        SizeHelper.defSizedBoxField,
                        CustomTextFormFieldLogin(
                          width: size.width * .8,
                          textInputType: TextInputType.datetime,
                          readOnly: true,
                          textEditingController: cubit.dateOfBirthController,
                          onTap: () => cubit.onTapBirthDate(context),
                          hintText: LocaleKeys.date_of_birth,
                          validator: generalValidator,
                        ),
                        SizeHelper.defSizedBoxField,
                        CustomTextFormFieldLogin(
                          width: size.width * .8,
                          textInputType: TextInputType.datetime,
                          readOnly: true,
                          textEditingController: cubit.gradDateController,
                          onTap: () => cubit.onTapGradDate(context),
                          hintText: LocaleKeys.graduation_date,
                          validator: generalValidator,
                        ),
                        SizeHelper.defSizedBoxField,
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * .1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(LocaleKeys.gender,
                                  style: AppStyles.styleSize14.copyWith(
                                      fontWeight: FontWeight.w500))
                                  .tr(),
                              FittedBox(
                                child: Row(
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
                                ),
                              )
                            ],
                          ),
                        ),
                        SizeHelper.defSizedBoxField,
                        CustomTwoFormFieldWidget(
                          fTitle: LocaleKeys.academic_year,
                          sTitle: LocaleKeys.gpa,
                          textEditingController1:
                          cubit.academicYearController,
                          textEditingController2: cubit.GPAController,
                        ),
                        SizeHelper.defSizedBoxField,
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.width * .1,
                              right: size.width * .1,
                              bottom: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              LocaleKeys.clinic_address,
                              style: AppStyles.styleSize14
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        CustomTwoFormFieldWidget(
                          fTitle: LocaleKeys.governorate,
                          sTitle: LocaleKeys.city,
                          textEditingController1:
                          cubit.governorateClinicController,
                          textEditingController2: cubit.cityController,
                          validator1: generalValidator,
                          validator2: generalValidator,
                        ),
                        SizeHelper.defSizedBoxField,
                        CustomTwoFormFieldWidget(
                          fTitle: LocaleKeys.street,
                          sTitle: LocaleKeys.building,
                          textEditingController2: cubit.buildingController,
                          textEditingController1: cubit.streetController,
                          validator1: generalValidator,
                          validator2: generalValidator,
                        ),
                        SizeHelper.defSizedBoxField,
                        CustomTwoFormFieldWidget(
                          fTitle: LocaleKeys.floor,
                          sTitle: 'other',
                          textEditingController2: cubit.floorController,
                          textEditingController1: cubit.otherController,
                          validator1: generalValidator,
                          validator2: generalValidator,
                        ),
                        SizeHelper.defSizedBoxField,
                        CustomTextFormFieldLogin(
                          width: size.width * .8,
                          textInputType: TextInputType.phone,
                          textEditingController: cubit.clinicPhoneController,
                          hintText: LocaleKeys.clinic_phone,
                          validator: generalValidator,
                        ),
                        SizeHelper.defSizedBoxField,
                        MultiInputFormField(
                          onSave: cubit.onAddInsuranceCompany,
                        ),
                        SizeHelper.defSizedBoxField,
                        SizeHelper.defSizedBoxField,
                        FittedBox(
                          child: CustomLoginButtonWidget(
                            title: LocaleKeys.save,
                            minWidth: size.width * .8,
                            onPressed: () {
                              if (cubit.isMale != null) {
                                if (cubit.formKey.currentState!.validate()) {
                                  cubit.updateDoctorData();
                                }
                              } else {
                                showCustomSnackBar(context,
                                    msg:
                                    LocaleKeys.please_select_your_gender);
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
    );
  }
}
