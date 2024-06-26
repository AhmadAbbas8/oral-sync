import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/core/shared_data_layer/actions_data_layer/model/Notification_model.dart';
import 'package:oralsync/features/home_student_feature/domain/use_cases/get_notifications_use_case.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/profile_student_page.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

import '../../../../../core/cache_helper/cache_storage.dart';
import '../../../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../../Auth/data/models/user_model.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit({required GetNotificationsUseCase getNotificationsUseCase})
      : _getNotificationsUseCase = getNotificationsUseCase,
        super(StudentInitial());
  final GetNotificationsUseCase _getNotificationsUseCase;
  int currentNavIndex = 0;
  List<String> bottomNavTitle = const [
    LocaleKeys.home,
    LocaleKeys.pending,
    LocaleKeys.messages,
    LocaleKeys.archived,
    LocaleKeys.reservations,
    LocaleKeys.profile,
  ];
  List<IconData> bottomNavIcons = const [
    IconBroken.Home,
    Icons.pending,
    IconBroken.Message,
    IconBroken.Arrow___Down_Square,
    IconBroken.Wallet,
    IconBroken.Profile,
  ];
  List<String> appBarTitles =const [
    LocaleKeys.home,
    LocaleKeys.pending,
    LocaleKeys.messages,
    LocaleKeys.archived,
    LocaleKeys.reservations,
  ];

  var studentModel = UserModel.fromJson(json.decode(
      ServiceLocator.instance<CacheStorage>()
          .getData(key: SharedPrefsKeys.user)));

  navBarOnTap(int index, BuildContext context) {

    if (index == 5) {

      context.pushNamed(ProfileStudentPage.routeName);
      return;
    }
    currentNavIndex = index;
    emit(ChangeNavBarIndex(index: index));
  }

  List<NotificationModel> notifications = [];

  getNotifications() async {
    emit(FetchNotificationLoading());
    var res = await _getNotificationsUseCase();
    res.fold(
          (failure) {
        if (failure is ServerFailure) {
          emit(FetchNotificationError(model: failure.errorModel!));
        } else if (failure is OfflineFailure) {
          emit(FetchNotificationError(model: failure.model!));
        }
      },
          (notifications) {
        this.notifications = notifications;
        emit(FetchNotificationSuccess());
      },
    );
  }
}
