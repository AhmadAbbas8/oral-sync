import 'package:easy_localization/easy_localization.dart';
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
import 'package:oralsync/features/Auth/domain/use_cases/login_use_case.dart';
import 'package:oralsync/features/Auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:oralsync/features/Auth/presentation/manager/methods.dart';
import 'package:oralsync/features/Auth/presentation/pages/sign_up_options_page.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_hint_button_widget.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_login_button_widget.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_text_form_field_login.dart';
import 'package:oralsync/features/Auth/presentation/widgets/forget_password_button_widget.dart';
import 'package:oralsync/features/student/presentation/pages/student_layout_screen.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

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
                        StudentLayoutScreen.routeName,
                        predicate: (route) => false,
                      );
                      showCustomSnackBar(context,
                          msg: 'Logging Successfully',
                          backgroundColor: Colors.green);
                    } else if (state is LoginError) {
                      context.pop();
                      showCustomSnackBar(context,
                          msg: state.errorModel?.messageEn ?? '',
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
                            LocaleKeys.hello,
                            style: AppStyles.styleSize28,
                          ).tr(),
                          const SizedBox(height: 20),
                          CustomTextFormFieldLogin(
                            width: size.width * .8,
                            hintText: 'Email or Phone number',
                            textEditingController:
                                cubit.emailTextEditingController,
                            prefixIcon: const Icon(Icons.person),
                            validator: validateEmail,
                          ),
                          SizeHelper.defSizedBoxField,
                          CustomTextFormFieldLogin(
                            width: size.width * .8,
                            hintText: 'Password',
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
                          const ForgetPasswordButtonWidget(),
                          SizeHelper.defSizedBoxField,
                          CustomLoginButtonWidget(
                            title: 'Sign in',
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
                            title: 'Don’t Have Any Account,',
                            buttonTitle: 'Sign Up',
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
}
