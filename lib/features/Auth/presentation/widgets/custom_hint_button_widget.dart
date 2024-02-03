import 'package:flutter/material.dart';
import 'package:oralsync/core/utils/styles.dart';

class CustomHintButtonWidget extends StatelessWidget {
  const CustomHintButtonWidget({
    super.key,
    required this.title,
    required this.buttonTitle,
    this.onPressed,
  });

  final String title;
  final String buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppStyles.styleSize14.copyWith(fontWeight: FontWeight.w500),
        ),
        TextButton(
            onPressed: onPressed,
            child: Text(
              buttonTitle,
              style: AppStyles.styleSize14.copyWith(
                  fontWeight: FontWeight.w500, color: const Color(0xFFAA2F2F)),
            ))
      ],
    );
  }
}
