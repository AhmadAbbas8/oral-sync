import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/features/reservations_feature/data/models/reservation_model.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../../../../core/utils/colors_palette.dart';

class CustomHomeDoctorCardWidget extends StatelessWidget {
  const CustomHomeDoctorCardWidget({
    super.key,
    required this.reservation,
    this.onPressedAccept,
    this.onPressedCancel,
    this.onPressedDone,
  });

  final ReservationModel reservation;
  final void Function()? onPressedAccept;
  final void Function()? onPressedCancel;
  final void Function()? onPressedDone;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 30,
              backgroundImage: CachedNetworkImageProvider(reservation
                      .user?.profileImage ??
                  "http://graduationprt24-001-site1.jtempurl.com/Profile/default/male.png"),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    reservation.user?.name ?? '',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${LocaleKeys.age.tr()}: ${reservation.user?.age} years',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${LocaleKeys.location}: ${reservation.location}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${LocaleKeys.date_created.tr()}: ${reservation.dateCreated} ${LocaleKeys.at.tr()} ${reservation.timeCreated}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: reservation.status?.toUpperCase() == 'WAITING'
                      ? onPressedAccept
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: ColorsPalette.buttonLoginColor,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    reservation.status?.toUpperCase() == 'WAITING'
                        ? LocaleKeys.accept
                        : LocaleKeys.accepted,
                    style: TextStyle(fontSize: 12.sp),
                  ).tr(),
                ),
                SizedBox(height: 8.h),
                ElevatedButton(
                  onPressed: onPressedCancel,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: ColorsPalette.buttonLoginColor,
                    side: const BorderSide(color: Colors.orange),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    LocaleKeys.cancel.tr(),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                SizedBox(height: 8.h),
                ElevatedButton(
                  onPressed: onPressedDone,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: ColorsPalette.buttonLoginColor,
                    side: const BorderSide(color: Colors.orange),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    LocaleKeys.done.tr(),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
