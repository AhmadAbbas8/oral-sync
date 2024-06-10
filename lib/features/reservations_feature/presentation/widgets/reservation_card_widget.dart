import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/features/reservations_feature/data/models/reservation_model.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

class AppointmentCard extends StatelessWidget {
  final ReservationModel reservation;

  const AppointmentCard({
    super.key,
    required this.reservation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: CachedNetworkImageProvider(reservation
                          .doctor?.profileImage ??
                      "http://graduationprt24-001-site1.jtempurl.com/Profile/default/male.png"),
                ),
                SizedBox(width: 16.w),
                Flexible(
                  child: Text(
                    reservation.doctor?.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              '${LocaleKeys.date_created.tr()}: ${reservation.dateCreated} ${reservation.timeCreated}',
              style: TextStyle(fontSize: 16.sp),
            ),
            Text(
              '${LocaleKeys.reservations_date.tr()}: ${reservation.dateAppointment} ${reservation.timeAppointment}',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              '${LocaleKeys.status.tr()}: ${reservation.status}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: reservation.status == 'Completed'
                    ? Colors.green
                    : Colors.red,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '${LocaleKeys.location.tr()}: ${reservation.location}',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              '${LocaleKeys.patient_notes.tr()}: ${reservation.patientNotes}',
              style: TextStyle(fontSize: 16.sp),
            ),
            Text(
              '${LocaleKeys.doctor_notes.tr()}: ${reservation.doctorNotes}',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              '${LocaleKeys.payment_method.tr()}: ${reservation.paymentMethod}',
              style: TextStyle(fontSize: 16.sp),
            ),
            Text(
              '${LocaleKeys.fee.tr()}: \$${reservation.fee?.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
