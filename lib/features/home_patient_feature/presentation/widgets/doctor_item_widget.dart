import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/features/home_patient_feature/data/models/DoctorModel.dart';
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
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32.w,
                child: Image.asset(
                  'assets/test/message_iamage.png',
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
                      '${doctor.firstName} ${doctor.lastName}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      handleClinicAddress(doctor.clinicAddresses ?? []),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                    const CustomDoctorRatingWidget(),
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
