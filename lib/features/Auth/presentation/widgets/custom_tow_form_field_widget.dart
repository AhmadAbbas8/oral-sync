import 'package:flutter/material.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_text_form_field_login.dart';

class CustomTwoFormFieldWidget extends StatelessWidget {
  const CustomTwoFormFieldWidget(
      {super.key,
      required this.fTitle,
      required this.sTitle,
      this.validator1,
      this.validator2,
       this.textEditingController1,
      this.textEditingController2});

  final String fTitle;
  final String sTitle;
  final String? Function(String?)? validator1;
  final String? Function(String?)? validator2;
  final TextEditingController? textEditingController1;
  final TextEditingController? textEditingController2;

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
            validator: validator1,
            textEditingController: textEditingController1,
          ),
          CustomTextFormFieldLogin(
            width: size.width * .37,
            hintText: sTitle,
            textInputType: TextInputType.text,
            validator: validator2,
            textEditingController: textEditingController2,
          ),
        ],
      ),
    );
  }
}
