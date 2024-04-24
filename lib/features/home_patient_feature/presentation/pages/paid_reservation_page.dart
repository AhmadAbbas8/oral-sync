import 'package:flutter/material.dart';
import '../widgets/doctor_item_widget.dart';

class PaidReservationPage extends StatelessWidget {
  const PaidReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) => const DoctorItemWidget(),
      itemCount: 30,
    );
  }
}
