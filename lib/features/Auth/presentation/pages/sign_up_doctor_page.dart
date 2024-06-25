import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/helpers/check_language.dart';
import 'package:oralsync/core/helpers/custom_progress_indicator.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/helpers/snackbars.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/assets_manager.dart';
import 'package:oralsync/core/utils/size_helper.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/Auth/domain/use_cases/login_use_case.dart';

import 'package:oralsync/features/Auth/presentation/manager/doctor_sign_up_cubit/doctor_sign_up_cubit.dart';
import 'package:oralsync/features/Auth/presentation/widgets/multi_input_form_field.dart';
import 'package:oralsync/features/home_doctor_feature/presentation/pages/doctor_home_layout.dart';

import 'package:oralsync/features/Auth/presentation/widgets/custom_login_button_widget.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_text_form_field_login.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_tow_form_field_widget.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../../../../core/helpers/general_validators.dart';
import '../../../../core/widgets/custom_alert_dialog_governorate.dart';
import '../../domain/use_cases/register_use_case.dart';
class SignUpDoctorPage extends StatefulWidget {
  const SignUpDoctorPage({super.key});

  static const routeName = '/signUpDoctorPage';

  @override
  State<SignUpDoctorPage> createState() => _SignUpDoctorStudentPageState();
}

class _SignUpDoctorStudentPageState extends State<SignUpDoctorPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    const List type = ['male', 'female'];
    return BlocProvider(
      create: (context) => DoctorSignUpCubit(
        loginUseCase: ServiceLocator.instance<LoginUseCase>(),
        newRegisterUseCase: ServiceLocator.instance<RegisterUseCase>(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: size.height),
              child: IntrinsicHeight(
                child: BlocConsumer<DoctorSignUpCubit, DoctorSignUpState>(
                  listener: (context, state) => stateHandler(state, context),
                  builder: (context, state) {
                    var cubit = context.read<DoctorSignUpCubit>();
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
                            LocaleKeys.sign_up_doctor,
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
                                            style:
                                                const TextStyle(fontSize: 14),
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
                                            style:
                                                const TextStyle(fontSize: 14),
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
                            // textInputType2: TextInputType.numberWithOptions(decimal: true),
                            inputFormatters2: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*$')),
                              CustomDoubleNumberInputFormatter(),
                            ],
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
                            readOnly1: true,
                            onTap1: () async {
                              var selectedGover =
                                  await showGovernorateDialog(context);
                              cubit.governorateClinicController.text =
                                  selectedGover ?? '';
                            },
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
                          Expanded(
                            child: CustomTextFormFieldLogin(
                              width: size.width * .8,
                              obscureText: cubit.obscurePassword,
                              validator: validatePassword,
                              suffixIcon: IconButton(
                                icon: Icon(cubit.obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () =>
                                    cubit.toggleVisibilityPassword(),
                              ),
                              textInputType: TextInputType.text,
                              hintText: LocaleKeys.password,
                              textEditingController: cubit.passwordController,
                            ),
                          ),
                          SizeHelper.defSizedBoxField,
                          FittedBox(
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
                                      msg:
                                          LocaleKeys.please_select_your_gender);
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

  void stateHandler(DoctorSignUpState state, BuildContext context) {
    if (state is RegisterDoctorLoading) {
      showCustomProgressIndicator(context);
    } else if (state is RegisterDoctorError) {
      context.pop();
      showCustomSnackBar(context,
          msg: isArabic(context)
              ? state.errorModel?.messageAr ?? ''
              : state.errorModel?.messageEn ?? '',
          backgroundColor: Colors.red);
    } else if (state is RegisterDoctorSuccess) {
      showCustomSnackBar(context,
          msg: LocaleKeys.user_created_successfully.tr(),
          backgroundColor: Colors.green);
      context.pop();
      context.pushNamed(HomeDoctorLayoutPage.routeName);
    }
  }
}

class CustomDoubleNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    const pattern = r'^(?:[2-4](?:\.\d{0,})?|5(?:\.0{0,})?)$';
    final regex = RegExp(pattern);
    if (newValue.text.isEmpty || regex.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}

