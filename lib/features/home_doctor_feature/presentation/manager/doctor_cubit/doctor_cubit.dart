import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/features/doctor_profile_feature/presentation/pages/doctor_profile_page.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../../../../../core/cache_helper/cache_storage.dart';
import '../../../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../../Auth/data/models/user_model.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorInitial());
  var doctorModel = UserModel.fromJson(json.decode(
      ServiceLocator.instance<CacheStorage>()
          .getData(key: SharedPrefsKeys.user)));
  int currentIndex = 0;
  List<String> appBarTitles = [
    LocaleKeys.home,
    LocaleKeys.messages,
    LocaleKeys.reservations,
  ];

  onChangeBottomNav(BuildContext context,int value) {
    if(value ==3) {
      context.pushNamed(DoctorProfilePage.routeName);
      return;
    }
    currentIndex = value;
    emit(BottomNavBarChanged(index: currentIndex));
  }
}
