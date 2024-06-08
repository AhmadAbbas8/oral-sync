import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/features/home_patient_feature/data/models/DoctorModel.dart';
import '../../../profiles_view_from_patient/presentation/pages/doctor_profile_patient_view_page.dart';
import 'custom_doctor_rating_widget.dart';

class DoctorItemWidget extends StatelessWidget {
  const DoctorItemWidget({
    super.key,
    required this.doctor,
  });

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () =>context.pushNamed(
          DoctorProfilePatientViewPage.routeName,
          arguments: doctor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Hero(
                tag: doctor.doctor?.doctorId??0,
                child: ClipOval(
                  // radius: 32.w,

                  child: FancyShimmerImage(
                    width: 100.w,
                    height: 100.h,
                    boxFit: BoxFit.contain,
                    imageUrl: doctor.profileImage ?? '',
                    errorWidget: Image.asset('assets/test/message_iamage.png'),
                  ),
                ),
              ),
              SizedBox(
                width: 18.w,
              ),
              Expanded(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${doctor.doctor?.firstName} ${doctor.doctor?.lastName}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      handleClinicAddress(doctor.doctor?.clinicAddresses ?? []),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                    CustomDoctorRatingWidget(
                      rateValue: doctor.averageRate?.toDouble() ?? 0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String handleClinicAddress(List<String> address) {
    return address
        .map((e) => e)
        .toString()
        .replaceAll(')', '')
        .replaceAll('(', '');
  }
}
