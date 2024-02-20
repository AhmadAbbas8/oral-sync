import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/helpers/general_validators.dart';

import 'package:oralsync/core/utils/size_helper.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_login_button_widget.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_text_form_field_login.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_tow_form_field_widget.dart';
import 'package:oralsync/translations/locale_keys.g.dart';


class EditProfilePage extends StatelessWidget {
  static const routeName = '/editProfilePage';

  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> type = ['male', 'female'];
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      /// TODO : remove this appbar after finishing this screen
      appBar: AppBar(),
      body: Form(
        child: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Column(
              children: [
                CustomTwoFormFieldWidget(
                  fTitle: LocaleKeys.first_name,
                  sTitle: LocaleKeys.last_name,
                  validator1: generalValidator,
                  validator2: generalValidator,
                ),
                SizeHelper.defSizedBoxField,
                CustomTextFormFieldLogin(
                  width: size.width * .8,
                  textInputType: TextInputType.emailAddress,
                  hintText: LocaleKeys.email,
                  validator: validateEmail,
                ),
                SizeHelper.defSizedBoxField,
                CustomTextFormFieldLogin(
                  width: size.width * .8,
                  textInputType: TextInputType.phone,
                  hintText: LocaleKeys.phone_number,
                  validator: generalValidator,
                ),
                SizeHelper.defSizedBoxField,
                CustomTextFormFieldLogin(
                  width: size.width * .8,
                  textInputType: TextInputType.text,
                  hintText: LocaleKeys.university_name,
                  validator: generalValidator,
                ),
                SizeHelper.defSizedBoxField,
                CustomTextFormFieldLogin(
                  width: size.width * .8,
                  textInputType: TextInputType.datetime,
                  readOnly: true,
                  // onTap: () => cubit.onTapBirthDate(context),
                  hintText: LocaleKeys.date_of_birth,
                  validator: generalValidator,
                ),
                SizeHelper.defSizedBoxField,
                CustomTextFormFieldLogin(
                  width: size.width * .8,
                  textInputType: TextInputType.datetime,
                  readOnly: true,

                  // onTap: () => cubit.onTapGradDate(context),
                  hintText: LocaleKeys.graduation_date,
                  validator: generalValidator,
                ),
                SizeHelper.defSizedBoxField,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(LocaleKeys.gender,
                              style: AppStyles.styleSize14
                                  .copyWith(fontWeight: FontWeight.w500))
                          .tr(),
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: RadioListTile<bool>.adaptive(
                              value: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              groupValue: true,
                              title: Text(
                                type[0],
                                style: const TextStyle(fontSize: 14),
                              ).tr(),
                              onChanged: null,
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: RadioListTile<bool>.adaptive(
                              value: false,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              groupValue: false,
                              title: Text(
                                type[1],
                                style: const TextStyle(fontSize: 14),
                              ).tr(),
                              onChanged: null,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizeHelper.defSizedBoxField,
                CustomTwoFormFieldWidget(
                  fTitle: LocaleKeys.academic_year,
                  sTitle: LocaleKeys.gpa,
                  validator2: generalValidator,
                  validator1: generalValidator,
                ),
                SizeHelper.defSizedBoxField,
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * .1, right: size.width * .1, bottom: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      LocaleKeys.university_address,
                      style: AppStyles.styleSize14
                          .copyWith(fontWeight: FontWeight.w500),
                    ).tr(),
                  ),
                ),
                CustomTwoFormFieldWidget(
                  fTitle: LocaleKeys.governorate,
                  sTitle: LocaleKeys.city,
                  validator1: generalValidator,
                  validator2: generalValidator,
                ),
                SizeHelper.defSizedBoxField,
                CustomTextFormFieldLogin(
                  width: size.width * .8,
                  obscureText:true,
                  validator: validatePassword,
                  suffixIcon: IconButton(
                    icon: Icon(true ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => 'cubit.toggleVisibilityPassword()',
                  ),
                  textInputType: TextInputType.text,
                  hintText: LocaleKeys.password,
                ),
                SizeHelper.defSizedBoxField,
                Expanded(
                  child: CustomLoginButtonWidget(
                    title: LocaleKeys.save,
                    minWidth: size.width * .8,
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
