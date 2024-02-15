import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/helpers/custom_progress_indicator.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/helpers/snackbars.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/size_helper.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/Auth/domain/use_cases/login_use_case.dart';
import 'package:oralsync/features/Auth/domain/use_cases/new_register_use_case.dart';

import 'package:oralsync/features/Auth/presentation/manager/methods.dart';
import 'package:oralsync/features/Auth/presentation/manager/student_sign_up_cubit/student_sign_up_cubit.dart';
import 'package:oralsync/features/home_fearure/presentation/pages/home_page.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_login_button_widget.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_text_form_field_login.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_tow_form_field_widget.dart';

import '../../../../core/utils/assets_manager.dart';

class SignUpStudentPage extends StatelessWidget {
  const SignUpStudentPage({super.key});

  static const routeName = '/signUpStudentPage';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    const List type = ['Male', 'Female'];
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
                          msg: state.errorModel?.messageEn ?? '',
                          backgroundColor: Colors.red);
                    } else if (state is RegisterStudentSuccess) {
                      showCustomSnackBar(context,
                          msg: 'User Created Successfully',
                          backgroundColor: Colors.green);
                      context.pop();
                      context.pushNamed(HomePage.routeName);
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
                            'Sign Up Student',
                            style: AppStyles.styleSize28,
                          ),
                          const SizedBox(height: 20),
                          CustomTwoFormFieldWidget(
                            fTitle: 'First Name',
                            sTitle: 'Last Name',
                            validator1: generalValidator,
                            validator2: generalValidator,
                            textEditingController1: cubit.fNameController,
                            textEditingController2: cubit.sNameController,
                          ),
                          SizeHelper.defSizedBoxField,
                          CustomTextFormFieldLogin(
                            width: size.width * .8,
                            textInputType: TextInputType.emailAddress,
                            hintText: 'Email',
                            validator: validateEmail,
                            textEditingController: cubit.emailController,
                          ),
                          SizeHelper.defSizedBoxField,
                          CustomTextFormFieldLogin(
                            width: size.width * .8,
                            textInputType: TextInputType.phone,
                            hintText: 'Phone Number',
                            validator: generalValidator,
                            textEditingController: cubit.phoneController,
                          ),
                          SizeHelper.defSizedBoxField,
                          CustomTextFormFieldLogin(
                            width: size.width * .8,
                            textInputType: TextInputType.text,
                            hintText: 'University Name',
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
                            hintText: 'Date Of Birth',
                            validator: generalValidator,
                          ),
                          SizeHelper.defSizedBoxField,
                          CustomTextFormFieldLogin(
                            width: size.width * .8,
                            textInputType: TextInputType.datetime,
                            readOnly: true,
                            textEditingController: cubit.gradDateController,
                            onTap: () => cubit.onTapGradDate(context),
                            hintText: 'Graduation Date',
                            validator: generalValidator,
                          ),
                          SizeHelper.defSizedBoxField,
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Gender',
                                    style: AppStyles.styleSize14
                                        .copyWith(fontWeight: FontWeight.w500)),
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
                                        ),
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
                                        ),
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
                            fTitle: 'Academic Year',
                            sTitle: 'GPA',
                            textEditingController1:
                                cubit.academicYearController,
                            textEditingController2: cubit.GPAController,
                            validator2: generalValidator,
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
                                'University Address',
                                style: AppStyles.styleSize14
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          CustomTwoFormFieldWidget(
                            fTitle: 'governorate',
                            sTitle: 'City',
                            validator1: generalValidator,
                            validator2: generalValidator,
                            textEditingController2: cubit.cityController,
                            textEditingController1: cubit.governorateController,
                          ),
                          SizeHelper.defSizedBoxField,
                          CustomTwoFormFieldWidget(
                            fTitle: 'Street',
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
                            hintText: 'Password',
                            textEditingController: cubit.passwordController,
                          ),
                          SizeHelper.defSizedBoxField,
                          Expanded(
                            child: CustomLoginButtonWidget(
                              title: 'Create Account',
                              minWidth: size.width * .8,
                              onPressed: () {
                                if (cubit.isMale != null) {
                                  if (cubit.formKey.currentState!.validate()) {
                                    cubit.register();
                                  }
                                } else {
                                  showCustomSnackBar(context,
                                      msg: 'Please Select your Gender');
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
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
