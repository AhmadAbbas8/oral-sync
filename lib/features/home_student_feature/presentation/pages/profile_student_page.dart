import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/shared_data_layer/edit_profile_data_layer/edit_repo.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/core/widgets/rating_wodget.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/custom_app_bar_action_button.dart';
import 'package:oralsync/features/home_student_feature/presentation/widgets/info_widget.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../../../../core/widgets/circle_avatar.dart';
import '../manager/student_edit_profile_cubit/student_edit_profile_cubit.dart';
import 'edit_profile_page.dart';

class ProfileStudentPage extends StatefulWidget {
  const ProfileStudentPage({super.key});

  static const routeName = '/profileStudentPage';

  @override
  State<ProfileStudentPage> createState() => _ProfileStudentPageState();
}

class _ProfileStudentPageState extends State<ProfileStudentPage> {
  var cubitPassed = StudentEditProfileCubit(
      cacheStorage: ServiceLocator.instance<CacheStorage>(),
      editProfileRepo: ServiceLocator.instance<EditProfileRepo>());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubitPassed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.profile).tr(),
          actions: [
            CustomAppBarActionButton(
              title: LocaleKeys.edit,
              onTap: () => context.pushNamed(
                EditProfilePage.routeName,
                arguments: cubitPassed,
              ),
            ),
            SizedBox(width: 5.w)
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child:
                BlocBuilder<StudentEditProfileCubit, StudentEditProfileState>(
              builder: (context, state) {
                var cubit = context.read<StudentEditProfileCubit>();
                final userData =
                    cubit.getStudentModel().userDetails as StudentDetails;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageProfileWidget(
                      imageProfile: cubit.getStudentModel().profileImage ?? '',
                      onPressed: () {},
                    ),
                    InfoWidget(
                      title:
                          '${userData.firstName ?? ''} ${userData.lastName ?? ''}',
                      icon: IconBroken.User,
                    ),
                    InfoWidget(
                      title: userData.email ?? '',
                      icon: IconBroken.Message,
                    ),
                    InfoWidget(
                      title: userData.phoneNumber ?? '',
                      icon: IconBroken.Call,
                    ),
                    InfoWidget(
                      title: userData.isMale ?? true ? 'Male' : 'Female',
                      icon: userData.isMale ?? true
                          ? FontAwesomeIcons.male
                          : FontAwesomeIcons.female,
                    ),
                    InfoWidget(
                      title:
                          '${userData.universitAddress.toString().replaceAll(']', '').replaceAll('[', '')}',
                      icon: IconBroken.Home,
                    ),
                    InfoWidget(
                        title: userData.academicYear.toString(),
                        icon: FontAwesomeIcons.buildingColumns),
                    InfoWidget(
                        title: userData.gpa.toString(),
                        icon: FontAwesomeIcons.pen),
                    RatingWidget()
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    cubitPassed.close();
    super.dispose();
  }
}
