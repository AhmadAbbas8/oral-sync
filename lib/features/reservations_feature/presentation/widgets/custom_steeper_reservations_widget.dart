import 'package:easy_localization/easy_localization.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/colors_palette.dart';
import '../../../../translations/locale_keys.g.dart';

class CustomStepperReservationsWidget extends StatefulWidget {
  const CustomStepperReservationsWidget({super.key});

  @override
  State<CustomStepperReservationsWidget> createState() =>
      _CustomStepperReservationsWidgetState();
}

class _CustomStepperReservationsWidgetState
    extends State<CustomStepperReservationsWidget> {
  int activeStep = 0;

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: activeStep,
      stepShape: StepShape.circle,
      stepBorderRadius: 15,
      borderThickness: 4,
      stepRadius: 28,
      finishedStepBorderColor: ColorsPalette.buttonLoginColor,
      finishedStepTextColor: ColorsPalette.buttonLoginColor,
      finishedStepBackgroundColor: ColorsPalette.buttonLoginColor,
      activeStepIconColor: ColorsPalette.buttonLoginColor,
      showLoadingAnimation: true,
      steps: [
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 1 ? 1 : 0.3,
              child: const Icon(Icons.pending),
            ),
          ),
          customTitle: const Text(
            LocaleKeys.pending,
            textAlign: TextAlign.center,
          ).tr(),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 2 ? 1 : 0.3,
              child: const Icon(Icons.done_outline_sharp),
            ),
          ),
          customTitle: const Text(
            LocaleKeys.accept,
            textAlign: TextAlign.center,
          ).tr(),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 3 ? 1 : 0.3,
              child: const Icon(Icons.done_all_sharp),
            ),
          ),
          customTitle: const Text(
            LocaleKeys.done,
            textAlign: TextAlign.center,
          ).tr(),
        ),
      ],
      onStepReached: (index) => setState(() => activeStep = index + 1),
    );
  }
}
