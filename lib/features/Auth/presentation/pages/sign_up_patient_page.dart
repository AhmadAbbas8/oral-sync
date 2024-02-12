import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/helpers/custom_progress_indicator.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/helpers/snackbars.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/assets_manager.dart';
import 'package:oralsync/core/utils/size_helper.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/Auth/domain/use_cases/register_use_case.dart';
import 'package:oralsync/features/Auth/domain/use_cases/sign_up_patient_use_case.dart';
import 'package:oralsync/features/Auth/presentation/manager/methods.dart';
import 'package:oralsync/features/Auth/presentation/manager/patient_sign_up_cubit/patient_sign_up_cubit.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_login_button_widget.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_text_form_field_login.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_tow_form_field_widget.dart';

class SignUpPatientPage extends StatelessWidget {
  const SignUpPatientPage({super.key});

  static const routeName = '/signUpPatientPage';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    const List type = ['Male', 'Female'];
    return BlocProvider(
      create: (context) => PatientSignUpCubit(
          registerUseCase: ServiceLocator.instance<RegisterUseCase>(),
          signUpPatientUseCase:
              ServiceLocator.instance<SignUpPatientUseCase>()),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: size.height),
              child: IntrinsicHeight(
                child: BlocConsumer<PatientSignUpCubit, PatientSignUpState>(
                  listener: (context, state) {
                    if (state is RegisterPatientLoading) {
                      showCustomProgressIndicator(context);
                    } else if (state is RegisterPatientError) {
                      context.pop();
                      showCustomSnackBar(context,
                          msg: state.errMessage, backgroundColor: Colors.red);
                    } else if (state is RegisterPatientSuccess) {
                      showCustomSnackBar(context,
                          msg: state.model.message ??
                              'User Created Successfully',
                          backgroundColor: Colors.green);
                      context.pop();
                    }
                  },
                  builder: (context, state) {
                    var cubit = context.read<PatientSignUpCubit>();
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
                            'Sign Up Patient',
                            style: AppStyles.styleSize28,
                          ),
                          const SizedBox(height: 20),
                          CustomTwoFormFieldWidget(
                            fTitle: 'First Name',
                            sTitle: 'Last Name',
                            validator1: generalValidator,
                            validator2: generalValidator,
                            textEditingController1: cubit.fNameController,
                            textEditingController2: cubit.lNameController,
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
                            textInputType: TextInputType.datetime,
                            readOnly: true,
                            textEditingController: cubit.dateOfBirthController,
                            onTap: () => cubit.onTapBirthDate(context),
                            hintText: 'Date Of Birth',
                          ),
                          SizeHelper.defSizedBoxField,
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gender',
                                  style: AppStyles.styleSize14.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
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
                                        title: Text(type[0],  style: TextStyle(fontSize: 14),),
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
                                        title: Text(type[1],  style: TextStyle(fontSize: 14),),
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
                            fTitle: 'Governorate',
                            sTitle: 'City',
                            textEditingController2: cubit.cityController,
                            textEditingController1: cubit.governorateController,
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
                                    cubit.registerUser();
                                  }
                                } else {
                                  showCustomSnackBar(context,
                                      msg: 'Please Select your Gender');
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
