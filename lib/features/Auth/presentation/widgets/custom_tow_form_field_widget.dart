import 'package:flutter/material.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_text_form_field_login.dart';

class CustomTwoFormFieldWidget extends StatelessWidget {
  const CustomTwoFormFieldWidget(
      {super.key, required this.fTitle, required this.sTitle});

  final String fTitle;
  final String sTitle;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextFormFieldLogin(
            width: size.width * .37,
            hintText: fTitle,
            textInputType: TextInputType.text,
          ),
          CustomTextFormFieldLogin(
            width: size.width * .37,
            hintText: sTitle,
            textInputType: TextInputType.text,
          ),
        ],
      ),
    );
  }
}
