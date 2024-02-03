import 'package:flutter/material.dart';
import 'package:oralsync/core/utils/assets_manager.dart';
import 'package:oralsync/core/utils/size_helper.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/Auth/presentation/pages/sign_up_options_page.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_hint_button_widget.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_login_button_widget.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_text_form_field_login.dart';
import 'package:oralsync/features/Auth/presentation/widgets/forget_password_button_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.height),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Image.asset(
                    AssetsManager.loginHeader,
                    fit: BoxFit.fitWidth,
                    width: size.width,
                  ),
                  const Text(
                    'Sign in',
                    style: AppStyles.styleSize28,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormFieldLogin(
                    width: size.width * .8,
                    hintText: 'Email or Phone number',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  SizeHelper.defSizedBoxField,
                  CustomTextFormFieldLogin(
                    width: size.width * .8,
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: const Icon(Icons.remove_red_eye),
                  ),
                  const ForgetPasswordButtonWidget(),
                  SizeHelper.defSizedBoxField,
                  CustomLoginButtonWidget(
                    title: 'Sign in',
                    minWidth: size.width * .8,
                    onPressed: () {},
                  ),
                  const Spacer(),
                  CustomHintButtonWidget(
                    title: 'Don’t Have Any Account,',
                    buttonTitle: 'Sign Up',
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpOptionsPage(),
                        )),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
