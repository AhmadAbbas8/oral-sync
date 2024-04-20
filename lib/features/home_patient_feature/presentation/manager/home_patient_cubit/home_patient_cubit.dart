import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/features/home_patient_feature/presentation/pages/profile_patient_page.dart';
import 'package:oralsync/features/home_student_feature/domain/use_cases/get_notifications_use_case.dart';

import '../../../../../core/cache_helper/cache_storage.dart';
import '../../../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../../../core/error/error_model.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../../../core/utils/icon_broken.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../../Auth/data/models/user_model.dart';
import '../../../../../core/shared_data_layer/actions_data_layer/model/Notification_model.dart';

part 'home_patient_state.dart';

class HomePatientCubit extends Cubit<HomePatientState> {
  HomePatientCubit({required GetNotificationsUseCase getNotificationsUseCase})
      : _getNotificationsUseCase = getNotificationsUseCase,
        super(HomePatientInitial());
  final GetNotificationsUseCase _getNotificationsUseCase;
  var patientModel = UserModel.fromJson(json.decode(
      ServiceLocator.instance<CacheStorage>()
          .getData(key: SharedPrefsKeys.user)));
  List<String> bottomNavTitle = const [
    LocaleKeys.free_reservation,
    LocaleKeys.paid_reservation,
    LocaleKeys.messages,
    LocaleKeys.reservations,
    LocaleKeys.profile,
  ];
  List<IconData> bottomNavIcons = const [
    Icons.money_off,
    Icons.attach_money,
    IconBroken.Message,
    IconBroken.Wallet,
    IconBroken.Profile,
  ];
  int currentNavIndex = 2;
  List<String> appBarTitles = const [
    LocaleKeys.free_reservation,
    LocaleKeys.paid_reservation,
    LocaleKeys.messages,
    LocaleKeys.reservations,
    LocaleKeys.profile,
  ];

  navBarOnTap(int index, BuildContext context) {
    if (index == 4) {
      context.pushNamed(ProfilePatientPage.routeName);
      return;
    }
    currentNavIndex = index;
    emit(ChangeNavBarIndexPatient(index: index));
  }
  List<NotificationModel> notifications = [];

  getNotifications() async {
    emit(FetchNotificationPatientLoading());
    var res = await _getNotificationsUseCase();
    res.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(
              FetchNotificationPatientError(responseModel: failure.errorModel));
        } else if (failure is OfflineFailure) {
          emit(FetchNotificationPatientError(responseModel: failure.model!));
        }
      },
      (notifications) {
        this.notifications = notifications;
        emit(FetchNotificationPatientSuccess());
      },
    );
  }
}
