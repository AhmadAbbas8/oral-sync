import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:fancy_shimmer_image/widgets/image_shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/core/widgets/info_widget.dart';
import 'package:oralsync/features/home_patient_feature/data/models/DoctorModel.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/widgets/custom_rating_bar_widget.dart';
import '../../../../translations/locale_keys.g.dart';
import '../widgets/custom_profile_button_widgets.dart';

class DoctorProfilePatientViewPage extends StatelessWidget {
  const DoctorProfilePatientViewPage({super.key, required this.doctorModel});

  static const routeName = '/DoctorProfilePatientViewPage';
  final DoctorModel doctorModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Hero(
              tag: doctorModel.doctor?.doctorId ?? 0,
              child: ClipOval(
                child: FancyShimmerImage(
                  imageUrl: doctorModel.profileImage ?? '',
                  width: 100.w,
                  errorWidget: Image.asset('assets/test/message_iamage.png'),
                  boxFit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 10.h),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomProfileButtonWidget(
                  title: LocaleKeys.message,
                  icon: IconBroken.Message,
                  onPressed: () {},
                ),
                CustomProfileButtonWidget(
                  title: LocaleKeys.reserve,
                  icon: IconBroken.Star,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Divider(
              thickness: 2,
              endIndent: 15,
              indent: 15,
            ),
          ),
          SliverList.list(
            children: [
              InfoWidget(
                title: doctorModel.name ?? '',
                icon: IconBroken.User,
              ),
              InfoWidget(
                title: doctorModel.doctor?.email ?? '',
                icon: IconBroken.Message,
              ),
              InfoWidget(
                title: doctorModel.doctor?.phoneNumber ?? '',
                icon: IconBroken.Call,
              ),
              InfoWidget(
                title: doctorModel.doctor?.isMale ?? true ? 'Male' : 'Female',
                icon: doctorModel.doctor?.isMale ?? true
                    ? FontAwesomeIcons.male
                    : FontAwesomeIcons.female,
              ),
              InfoWidget(
                title: doctorModel.doctor?.birthDate ?? '',
                icon: IconBroken.Calendar,
              ),
              InfoWidget(
                title: doctorModel.doctor?.universityName ?? '',
                icon: FontAwesomeIcons.buildingColumns,
              ),
              InfoWidget(
                title: doctorModel.doctor!.clinicAddresses
                    .toString()
                    .replaceAll(']', '')
                    .replaceAll('[', ''),
                icon: IconBroken.Home,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Wrap(
                  children: doctorModel.doctor?.insuranceCompanies
                          ?.map<Chip>(
                            (element) => Chip(
                              label: Text(
                                element ?? '',
                              ),
                              backgroundColor: Colors.blue[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          )
                          .toList() ??
                      [],
                ),
              ),
              CustomRatingBarWidget(
                rating: doctorModel.averageRate?.toDouble() ?? 0.0,
              )
            ],
          ),
        ],
      ),
    );
  }
}
