import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oralsync/core/utils/assets_manager.dart';
import 'package:oralsync/core/utils/size_helper.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/Auth/presentation/pages/sign_up_doctor_page.dart';
import 'package:oralsync/features/Auth/presentation/pages/sign_up_patient_page.dart';
import 'package:oralsync/features/Auth/presentation/pages/sign_up_student_page.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_hint_button_widget.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_login_button_widget.dart';

import '../../../../translations/locale_keys.g.dart';

class SignUpOptionsPage extends StatelessWidget {
  const SignUpOptionsPage({super.key});
  static const routeName = '/SignUpOptionsPage';
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
                    LocaleKeys.sign_up_as,
                    style: AppStyles.styleSize28,
                  ).tr(),
                  const SizedBox(height: 20),
                  CustomLoginButtonWidget(
                    title: LocaleKeys.patient,
                    minWidth: size.width * .8,
                    onPressed: () =>Navigator.pushNamed(context, SignUpPatientPage.routeName),
                  ),
                  SizeHelper.defSizedBoxField,
                  CustomLoginButtonWidget(
                    title:  LocaleKeys.doctor,
                    minWidth: size.width * .8,
                    onPressed: () =>Navigator.pushNamed(context, SignUpDoctorPage.routeName),
                  ),
                  SizeHelper.defSizedBoxField,
                  CustomLoginButtonWidget(
                    title:  LocaleKeys.medical_student,
                    minWidth: size.width * .8,
                    onPressed: () =>Navigator.pushNamed(context, SignUpStudentPage.routeName),
                  ),
                  const Spacer(),
                  CustomHintButtonWidget(
                    title:  LocaleKeys.if_you_have_account,
                    buttonTitle:  LocaleKeys.sign_in,
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
