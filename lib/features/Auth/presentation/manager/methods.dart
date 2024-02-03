import 'package:flutter/material.dart';
import 'package:oralsync/core/utils/size_helper.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_tow_form_field_widget.dart';

List<Widget> getFormFieldDoctorStudent(
    {required BuildContext context, bool? isDoc}) {
  var size = MediaQuery.sizeOf(context);
  if (isDoc == null)
    return const [];
  else if (!isDoc)
    return [
      SizeHelper.defSizedBoxField,
      const CustomTwoFormFieldWidget(fTitle: 'Academic Year', sTitle: 'GPA'),
      SizeHelper.defSizedBoxField,
      Padding(
        padding: EdgeInsets.only(
            left: size.width * .1, right: size.width * .1, bottom: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'University Address',
            style: AppStyles.styleSize14.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      const CustomTwoFormFieldWidget(fTitle: 'Government', sTitle: 'City'),
      SizeHelper.defSizedBoxField,
      const CustomTwoFormFieldWidget(fTitle: 'Street', sTitle: 'other'),
      SizeHelper.defSizedBoxField,
    ];
  else
    return [
      SizeHelper.defSizedBoxField,
      const CustomTwoFormFieldWidget(fTitle: 'Academic Year', sTitle: 'GPA'),
      SizeHelper.defSizedBoxField,
      Padding(
        padding: EdgeInsets.only(
            left: size.width * .1, right: size.width * .1, bottom: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Clinic Address',
            style: AppStyles.styleSize14.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      const CustomTwoFormFieldWidget(fTitle: 'Government', sTitle: 'City'),
      SizeHelper.defSizedBoxField,
      const CustomTwoFormFieldWidget(fTitle: 'Street', sTitle: 'Building'),
      SizeHelper.defSizedBoxField,
      const CustomTwoFormFieldWidget(fTitle: 'Floor', sTitle: 'Other'),
      SizeHelper.defSizedBoxField,
    ];
}
