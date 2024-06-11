import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/helpers/check_language.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/features/reservations_feature/data/models/reservation_model.dart';
import 'package:oralsync/features/reservations_feature/presentation/pages/add_rate_page.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../../../../core/cache_helper/cache_storage.dart';
import '../../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/colors_palette.dart';
import '../../../Auth/data/models/user_model.dart';

class AppointmentCard extends StatelessWidget {
  final ReservationModel reservation;

  const AppointmentCard({
    super.key,
    required this.reservation,
  });

  @override
  Widget build(BuildContext context) {
    var cache =  ServiceLocator.instance<CacheStorage>();
    var userJson = cache.getData(key: SharedPrefsKeys.user);
    var user  = UserModel.fromJson(json.decode(userJson));
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: CachedNetworkImageProvider(reservation
                          .user?.profileImage ??
                      "http://graduationprt24-001-site1.jtempurl.com/Profile/default/male.png"),
                ),
                SizedBox(width: 16.w),
                Flexible(
                  child: Text(
                    reservation.user?.name ?? '',
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
              '${LocaleKeys.status.tr()}: Completed',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
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
            if(user.userRole?.toUpperCase() == 'Patient'.toUpperCase())    Align(
              alignment: isArabic(context)
                  ? Alignment.bottomLeft
                  : Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: reservation.isRating ?? true
                    ? null
                    : () => context.pushNamed(AddRatePage.routeName,arguments: reservation),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: ColorsPalette.buttonLoginColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(
                  reservation.isRating ?? true
                      ? LocaleKeys.rated
                      : LocaleKeys.add_rate,
                  style: TextStyle(fontSize: 12.sp),
                ).tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
