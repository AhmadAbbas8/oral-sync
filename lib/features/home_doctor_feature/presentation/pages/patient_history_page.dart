import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../../../reservations_feature/data/models/reservation_model.dart';
import '../../../reservations_feature/presentation/widgets/reservation_card_widget.dart';

class PatientHistoryPage extends StatelessWidget {
  const PatientHistoryPage({super.key, required this.histories});

  static const routeName = '/PatientHistoryPage';
  final List<ReservationModel> histories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.history).tr(),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          itemBuilder: (_, index) =>  AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 1000),
            child: SlideAnimation(
              horizontalOffset: 50,
              child: FadeInAnimation(
                child: AppointmentCard(
                  reservation: histories[index],
                ),
              ),
            ),
          ),
          itemCount: histories.length,
        ),
      ),
    );
  }
}
