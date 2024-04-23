import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/helpers/check_language.dart';
import 'package:oralsync/core/helpers/custom_progress_indicator.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/helpers/general_validators.dart';
import 'package:oralsync/core/helpers/snackbars.dart';
import 'package:oralsync/core/utils/colors_palette.dart';

import 'package:oralsync/core/utils/size_helper.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_login_button_widget.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_text_form_field_login.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_tow_form_field_widget.dart';
import 'package:oralsync/features/home_student_feature/presentation/manager/student_edit_profile_cubit/student_edit_profile_cubit.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../../../../core/helpers/reg_ex.dart';

class EditProfileStudentPage extends StatelessWidget {
  static const routeName = '/editProfileStudentPage';
  final StudentEditProfileCubit passedCubit;

  const EditProfileStudentPage({super.key, required this.passedCubit});

  @override
  Widget build(BuildContext context) {
    List<String> type = ['male', 'female'];
    var size = MediaQuery.sizeOf(context);
    return BlocProvider.value(
      // create: (context) => StudentEditProfileCubit(
      //     editProfileRepo: ServiceLocator.instance<EditProfileRepo>(),
      //     cacheStorage: ServiceLocator.instance<CacheStorage>())
      //   ..onOpenEditPage(),
      value: passedCubit..onOpenEditPage(),
      child: BlocConsumer<StudentEditProfileCubit, StudentEditProfileState>(
        listener: (context, state) {
          if (state is UpdateStudentDataLoading) {
            showCustomProgressIndicator(context);
          } else if (state is UpdateStudentDataError) {
            context.pop();
            showCustomSnackBar(
              context,
              msg: isArabic(context)
                  ? state.responseModel.messageAr ?? ''
                  : state.responseModel.messageEn ?? '',
              backgroundColor: ColorsPalette.errorColor,
            );
          } else if (state is UpdateStudentDataSuccess) {
            context.pop();
            context.pop();
            showCustomSnackBar(
              context,
              msg: 'updated_successfully'.tr(),
              backgroundColor: ColorsPalette.successColor,
            );
          }
        },
        buildWhen: (previous, current) => previous != current,
        listenWhen: (previous, current) => previous != current,
        builder: (context, state) {
          var cubit = context.read<StudentEditProfileCubit>();
          return Scaffold(
            appBar: AppBar(
              title: const Text(LocaleKeys.edit_data).tr(),
            ),
            body: Form(
              key: cubit.formKey,
              child: SingleChildScrollView(
                child: IntrinsicHeight(
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: validatePhoneNumber,
                        textEditingController: cubit.phoneController,
                      ),
                      SizeHelper.defSizedBoxField,
                      CustomTextFormFieldLogin(
                        width: size.width * .8,
                        textInputType: TextInputType.text,
                        hintText: LocaleKeys.university_name,
                        validator: generalValidator,
                        textEditingController: cubit.universityController,
                      ),
                      SizeHelper.defSizedBoxField,
                      CustomTextFormFieldLogin(
                        width: size.width * .8,
                        textInputType: TextInputType.datetime,
                        readOnly: true,
                        onTap: () => cubit.onTapBirthDate(context),
                        hintText: LocaleKeys.date_of_birth,
                        validator: generalValidator,
                        textEditingController: cubit.dobController,
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
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * .1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocaleKeys.gender,
                                    style: AppStyles.styleSize14
                                        .copyWith(fontWeight: FontWeight.w500))
                                .tr(),
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
                        fTitle: LocaleKeys.academic_year,
                        sTitle: LocaleKeys.gpa,
                        validator1: academicValidator,
                        validator2: gpaValidator,
                        textInputType1: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters1: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textInputType2: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters2: [
                          FilteringTextInputFormatter.allow(
                            RegExp(CustomRegEx.onDoubleValue),
                          )
                        ],
                        textEditingController1: cubit.academicYearController,
                        textEditingController2: cubit.gpaController,
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
                            LocaleKeys.university_address,
                            style: AppStyles.styleSize14
                                .copyWith(fontWeight: FontWeight.w500),
                          ).tr(),
                        ),
                      ),
                      CustomTwoFormFieldWidget(
                        fTitle: LocaleKeys.governorate,
                        sTitle: LocaleKeys.city,
                        validator1: generalValidator,
                        validator2: generalValidator,
                        textEditingController1:
                            cubit.universityGovernorateController,
                        textEditingController2: cubit.universityCityController,
                      ),
                      // SizeHelper.defSizedBoxField,
                      // CustomTextFormFieldLogin(
                      //   width: size.width * .8,
                      //   obscureText: true,
                      //   validator: validatePassword,
                      //   suffixIcon: IconButton(
                      //     icon: const Icon(
                      //         true ? Icons.visibility : Icons.visibility_off),
                      //     onPressed: () => c,
                      //   ),
                      //   textInputType: TextInputType.text,
                      //   hintText: LocaleKeys.password,
                      // ),
                      SizeHelper.defSizedBoxField,
                      Expanded(
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
                                  backgroundColor: ColorsPalette.warningColor);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
