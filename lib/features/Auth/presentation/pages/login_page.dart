import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/helpers/check_language.dart';
import 'package:oralsync/core/helpers/custom_progress_indicator.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/helpers/snackbars.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/assets_manager.dart';
import 'package:oralsync/core/utils/size_helper.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/Auth/domain/use_cases/login_use_case.dart';
import 'package:oralsync/features/Auth/presentation/manager/login_cubit/login_cubit.dart';

import 'package:oralsync/features/Auth/presentation/pages/sign_up_options_page.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_hint_button_widget.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_login_button_widget.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_text_form_field_login.dart';
import 'package:oralsync/features/Auth/presentation/widgets/forget_password_button_widget.dart';
import 'package:oralsync/features/Auth/presentation/widgets/keep_me_logged_in_widget.dart';
import 'package:oralsync/features/home_fearure/presentation/pages/home_page.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/student_home_layout_page.dart';

import 'package:oralsync/translations/locale_keys.g.dart';

import '../../../../core/helpers/general_validators.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const routeName = '/loginPage';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) =>
          LoginCubit(loginUseCase: ServiceLocator.instance<LoginUseCase>()),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: size.height),
              child: IntrinsicHeight(
                child: BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginLoading) {
                      showCustomProgressIndicator(context);
                    } else if (state is LoginSuccess) {
                      context.pop();
                      context.pushNamedAndRemoveUntil(
                        manageRouteName(state.user?.userRole ?? ''),
                        predicate: (route) => false,
                      );
                      showCustomSnackBar(context,
                          msg: LocaleKeys.user_created_successfully.tr(),
                          backgroundColor: Colors.green);
                    } else if (state is LoginError) {
                      context.pop();
                      showCustomSnackBar(context,
                          msg: isArabic(context)
                              ? state.errorModel?.messageAr ?? ''
                              : state.errorModel?.messageEn ?? '',
                          backgroundColor: Colors.red);
                    }
                  },
                  builder: (context, state) {
                    var cubit = context.read<LoginCubit>();
                    return Form(
                      key: cubit.formKey,
                      child: Column(
                        children: [
                          Image.asset(
                            AssetsManager.loginHeader,
                            fit: BoxFit.fitWidth,
                            width: size.width,
                          ),
                          const Text(
                            LocaleKeys.sign_in,
                            style: AppStyles.styleSize28,
                          ).tr(),
                          const SizedBox(height: 20),
                          CustomTextFormFieldLogin(
                            width: size.width * .8,
                            hintText: LocaleKeys.email,
                            textEditingController:
                                cubit.emailTextEditingController,
                            prefixIcon: const Icon(Icons.person),
                            validator: validateEmail,
                          ),
                          SizeHelper.defSizedBoxField,
                          CustomTextFormFieldLogin(
                            width: size.width * .8,
                            hintText: LocaleKeys.password,
                            obscureText: cubit.obscurePassword,
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(cubit.obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () => cubit.toggleVisibilityPassword(),
                            ),
                            textEditingController:
                                cubit.passwordTextEditingController,
                            validator: validatePassword,
                          ),
                          SizedBox(
                            width: size.width * 0.8,
                            child: KeepMeLoggedInWidget(
                              value: cubit.keepMeLoggedIn,
                              title: LocaleKeys.keep_me_logged_in,
                              onChanged: (value) => cubit.onTapKeepMeLoggedIn(),
                            ),
                          ),
                          const ForgetPasswordButtonWidget(),
                          SizeHelper.defSizedBoxField,
                          CustomLoginButtonWidget(
                            title: LocaleKeys.sign_in,
                            minWidth: size.width * .8,
                            onPressed: () {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.login(
                                  email: cubit.emailTextEditingController.text,
                                  password:
                                      cubit.passwordTextEditingController.text,
                                );
                              }
                            },
                          ),
                          const Spacer(),
                          CustomHintButtonWidget(
                            title: LocaleKeys.do_not_have_any_account,
                            buttonTitle: LocaleKeys.sign_up,
                            onPressed: () => Navigator.pushNamed(
                                context, SignUpOptionsPage.routeName),
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

  String manageRouteName(String role) {
    if (role == 'Student') {
      return StudentHomeLayoutPage.routeName;
    }
    return HomePage.routeName;
  }
}
