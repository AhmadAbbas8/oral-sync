import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oralsync/core/utils/assets_manager.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/core/utils/size_helper.dart';
import 'package:oralsync/core/utils/styles.dart';
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
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide.none,
                    ),
                    clipBehavior: Clip.hardEdge,
                    color: const Color(0xFFAA2F2F),
                    minWidth: size.width * .8,
                    height: 50,
                    textColor: Colors.white,
                    child: const Text('Sign in'),
                    onPressed: () {},
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t Have Any Account,',
                        style: AppStyles.styleSize14
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Sign Up',
                            style: AppStyles.styleSize14.copyWith(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFAA2F2F)),
                          ))
                    ],
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
