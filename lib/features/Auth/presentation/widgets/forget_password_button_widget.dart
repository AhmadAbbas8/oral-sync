import 'package:flutter/material.dart';
import 'package:oralsync/core/utils/styles.dart';

class ForgetPasswordButtonWidget extends StatelessWidget {
  const ForgetPasswordButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: MediaQuery.sizeOf(context).width * .09),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {},
          child: const Text(
            'Forget Your Password ?',
            style: AppStyles.styleSize14,
          ),
        ),
      ),
    );
  }
}
