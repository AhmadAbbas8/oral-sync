import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/profile_student_page.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../../../../../core/cache_helper/cache_storage.dart';
import '../../../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../../Auth/data/models/user_model.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit() : super(StudentInitial());
  int currentNavIndex = 0;
  List<String> bottomNavTitle = const [
    LocaleKeys.home,
    LocaleKeys.messages,
    LocaleKeys.archived,
    LocaleKeys.profile,
  ];
  List<IconData> bottomNavIcons = const [
    IconBroken.Home,
    IconBroken.Message,
    Icons.archive_outlined,
    IconBroken.Profile,
  ];


  var studentModel = UserModel.fromJson(json.decode(
      ServiceLocator.instance<CacheStorage>()
          .getData(key: SharedPrefsKeys.user)));

  navBarOnTap(int index,BuildContext context) {
    if(index == 3) {
      context.pushNamed(ProfileStudentPage.routeName);
      return ;
    }
    currentNavIndex = index;
    emit(ChangeNavBarIndex(index: index));
  }
}
