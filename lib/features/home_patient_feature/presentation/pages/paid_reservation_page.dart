import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
