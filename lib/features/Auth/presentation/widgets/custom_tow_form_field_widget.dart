import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oralsync/features/Auth/presentation/widgets/custom_text_form_field_login.dart';

class CustomTwoFormFieldWidget extends StatelessWidget {
  const CustomTwoFormFieldWidget({
    super.key,
    required this.fTitle,
    required this.sTitle,
    this.validator1,
    this.validator2,
    this.textEditingController1,
    this.textEditingController2,
    this.textInputType1,
    this.textInputType2,
    this.inputFormatters1,
    this.inputFormatters2,
    this.onTap1,
    this.readOnly1,
  });

  final String fTitle;
  final String sTitle;
  final String? Function(String?)? validator1;
  final String? Function(String?)? validator2;
  final TextEditingController? textEditingController1;
  final TextEditingController? textEditingController2;
  final TextInputType? textInputType1;
  final TextInputType? textInputType2;
  final List<TextInputFormatter>? inputFormatters1;
  final List<TextInputFormatter>? inputFormatters2;
  final void Function()? onTap1;
  final bool? readOnly1;

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
            textInputType: textInputType1 ?? TextInputType.text,
            inputFormatters: inputFormatters1,
            validator: validator1,
            textEditingController: textEditingController1,
            onTap: onTap1,
            readOnly: readOnly1,
          ),
          CustomTextFormFieldLogin(
            width: size.width * .37,
            inputFormatters: inputFormatters2,
            hintText: sTitle,
            textInputType: textInputType2 ?? TextInputType.text,
            validator: validator2,
            textEditingController: textEditingController2,
          ),
        ],
      ),
    );
  }
}
