import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/helpers/check_language.dart';
import 'package:oralsync/core/helpers/custom_progress_indicator.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/helpers/snackbars.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/size_helper.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/Auth/domain/use_cases/login_use_case.dart';
import 'package:oralsync/features/Auth/domain/use_cases/new_register_use_case.dart';

import 'package:oralsync/features/Auth/presentation/manager/student_sign_up_cubit/student_sign_up_cubit.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_login_button_widget.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_text_form_field_login.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_tow_form_field_widget.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/student_home_layout_page.dart';

import '../../../../core/helpers/general_validators.dart';
import '../../../../core/helpers/reg_ex.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../translations/locale_keys.g.dart';

class SignUpStudentPage extends StatelessWidget {
  const SignUpStudentPage({super.key});

  static const routeName = '/signUpStudentPage';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    const List type = ['male', 'female'];
    return BlocProvider(
      create: (context) => StudentSignUpCubit(
        loginUseCase: ServiceLocator.instance<LoginUseCase>(),
        newRegisterUseCase: ServiceLocator.instance<NewRegisterUseCase>(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: size.height),
              child: IntrinsicHeight(
                child: BlocConsumer<StudentSignUpCubit, StudentSignUpState>(
                  listener: (context, state) {
                    if (state is RegisterStudentLoading) {
                      showCustomProgressIndicator(context);
                    } else if (state is RegisterStudentError) {
                      context.pop();
                      showCustomSnackBar(context,
                          msg: isArabic(context)
                              ? state.errorModel?.messageAr ?? ''
                              : state.errorModel?.messageEn ?? '',
                          backgroundColor: Colors.red);
                    } else if (state is RegisterStudentSuccess) {
                      showCustomSnackBar(context,
                          msg: LocaleKeys.user_created_successfully.tr(),
                          backgroundColor: Colors.green);
                      context.pop();
                      context.pushNamedAndRemoveUntil(
                          StudentHomeLayoutPage.routeName,
                          predicate: (route) => false);
                    }
                  },
                  builder: (context, state) {
                    var cubit = context.read<StudentSignUpCubit>();
                    return Form(
                      key: cubit.formKey,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                AssetsManager.loginHeader,
                                fit: BoxFit.fitWidth,
                                width: size.width,
                              ),
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                color: Colors.black87,
                                icon: Icon(
                                  Icons.adaptive.arrow_back,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            LocaleKeys.sign_up_student,
                            style: AppStyles.styleSize28,
                          ).tr(),
                          const SizedBox(height: 20),
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
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            hintText: LocaleKeys.phone_number,
                            validator: validatePhoneNumber,
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
                            textInputType1:const   TextInputType.numberWithOptions(decimal: true),
                            inputFormatters1: [FilteringTextInputFormatter.digitsOnly],
                            textInputType2:
                                const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters2: [
                              FilteringTextInputFormatter.allow(
                                RegExp(CustomRegEx.onDoubleValue),
                              )
                            ],
                            textEditingController1:
                                cubit.academicYearController,
                            textEditingController2: cubit.GPAController,
                            validator2: gpaValidator,
                            validator1: generalValidator,
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
                            textEditingController2: cubit.cityController,
                            textEditingController1: cubit.governorateController,
                          ),
                          SizeHelper.defSizedBoxField,
                          CustomTwoFormFieldWidget(
                            fTitle: LocaleKeys.street,
                            sTitle: 'other',
                            validator1: generalValidator,
                            validator2: generalValidator,
                            textEditingController2: cubit.streetController,
                            textEditingController1: cubit.otherController,
                          ),
                          SizeHelper.defSizedBoxField,
                          CustomTextFormFieldLogin(
                            width: size.width * .8,
                            obscureText: cubit.obscurePassword,
                            validator: validatePassword,
                            suffixIcon: IconButton(
                              icon: Icon(cubit.obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () => cubit.toggleVisibilityPassword(),
                            ),
                            textInputType: TextInputType.text,
                            hintText: LocaleKeys.password,
                            textEditingController: cubit.passwordController,
                          ),
                          SizeHelper.defSizedBoxField,
                          Expanded(
                            child: CustomLoginButtonWidget(
                              title: LocaleKeys.create_account,
                              minWidth: size.width * .8,
                              onPressed: () {
                                if (cubit.isMale != null) {
                                  if (cubit.formKey.currentState!.validate()) {
                                    cubit.register();
                                  }
                                } else {
                                  showCustomSnackBar(context,
                                      msg: LocaleKeys.please_select_your_gender
                                          .tr());
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
