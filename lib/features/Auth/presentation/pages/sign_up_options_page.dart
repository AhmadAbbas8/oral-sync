import 'package:flutter/material.dart';
import 'package:oralsync/core/utils/assets_manager.dart';
import 'package:oralsync/core/utils/size_helper.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/Auth/presentation/pages/sign_up_patient_page.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_hint_button_widget.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_login_button_widget.dart';

class SignUpOptionsPage extends StatelessWidget {
  const SignUpOptionsPage({super.key});

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
                  Stack(
                    children: [
                      Image.asset(
                        AssetsManager.signUpOptionsHeader,
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
                    'Sign Up as a',
                    style: AppStyles.styleSize28,
                  ),
                  const SizedBox(height: 20),
                  CustomLoginButtonWidget(
                    title: 'Patient',
                    minWidth: size.width * .8,
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPatientPage(),
                        )),
                  ),
                  SizeHelper.defSizedBoxField,
                  CustomLoginButtonWidget(
                    title: 'Doctor or Medical Student',
                    minWidth: size.width * .8,
                    onPressed: () {},
                  ),
                  const Spacer(),
                  CustomHintButtonWidget(
                    title: 'If You Have Account,',
                    buttonTitle: 'Sign in',
                    onPressed: () => Navigator.pop(context),
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
