import 'package:flutter/material.dart';
import 'package:oralsync/core/utils/assets_manager.dart';
import 'package:oralsync/core/utils/size_helper.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/Auth/presentation/manager/methods.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_login_button_widget.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_text_form_field_login.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_tow_form_field_widget.dart';

class SignUpDoctorStudentPage extends StatefulWidget {
  const SignUpDoctorStudentPage({super.key});
  static const routeName = '/signUpDoctorStudentPage';
  @override
  State<SignUpDoctorStudentPage> createState() =>
      _SignUpDoctorStudentPageState();
}

class _SignUpDoctorStudentPageState extends State<SignUpDoctorStudentPage> {
  bool? isDoctor;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    const List type = ['Male', 'Female'];
    const List type2 = ['Doctor', 'Student'];
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
                    'Sign Up Medical Stuff',
                    style: AppStyles.styleSize28,
                  ),
                  const SizedBox(height: 20),
                  const CustomTwoFormFieldWidget(
                      fTitle: 'First Name', sTitle: 'Last Name'),
                  SizeHelper.defSizedBoxField,
                  CustomTextFormFieldLogin(
                    width: size.width * .8,
                    textInputType: TextInputType.emailAddress,
                    hintText: 'Email',
                  ),
                  SizeHelper.defSizedBoxField,
                  CustomTextFormFieldLogin(
                    width: size.width * .8,
                    textInputType: TextInputType.phone,
                    hintText: 'Phone Number',
                  ),
                  SizeHelper.defSizedBoxField,
                  CustomTextFormFieldLogin(
                    width: size.width * .8,
                    textInputType: TextInputType.datetime,
                    readOnly: true,
                    onTap: () {
                      /// TODO:show DatePicker Here
                    },
                    hintText: 'Date Of Birth',
                  ),
                  SizeHelper.defSizedBoxField,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Gender',
                            style: AppStyles.styleSize14
                                .copyWith(fontWeight: FontWeight.w500)),
                        Row(
                          children: List<Widget>.generate(
                            2,
                            (index) => SizedBox(
                              width: 150,
                              child: RadioListTile<bool>.adaptive(
                                value: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                groupValue: false,
                                title: Text(type[index]),
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizeHelper.defSizedBoxField,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          SizedBox(
                            width: 150,
                            child: RadioListTile<bool>.adaptive(
                              value: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              groupValue: isDoctor,
                              title: Text(type2[0]),
                              onChanged: (value) {
                                setState(() {
                                  isDoctor = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: RadioListTile<bool>.adaptive(
                              value: false,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              groupValue: isDoctor,
                              title: Text(type2[1]),
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  isDoctor = value;
                                });
                              },
                            ),
                          )
                        ])
                      ],
                    ),
                  ),
                  ...getFormFieldDoctorStudent(
                      context: context, isDoc: isDoctor),
                  CustomTextFormFieldLogin(
                    width: size.width * .8,
                    obscureText: true,
                    suffixIcon: const Icon(Icons.visibility),
                    textInputType: TextInputType.text,
                    hintText: 'Password',
                  ),
                  SizeHelper.defSizedBoxField,
                  CustomLoginButtonWidget(
                    title: 'Create Account',
                    minWidth: size.width * .8,
                    onPressed: () {},
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
