import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/features/reservations_feature/data/repo/reservations_repo.dart';

import '../../../../../core/cache_helper/cache_storage.dart';
import '../../../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../../../core/utils/end_points.dart';
import '../../../../Auth/data/models/user_model.dart';
import '../../../data/models/reservation_model.dart';

part 'reservations_state.dart';

class ReservationsCubit extends Cubit<ReservationsState> {
  ReservationsCubit({
    required this.reservationsRepo,
    required this.cacheStorage,
  }) : super(ReservationsInitial());
  final ReservationsRepo reservationsRepo;
  final CacheStorage cacheStorage;
  List<ReservationModel> reservations = [];

  String getEndpoint() {
    var userJson = cacheStorage.getData(key: SharedPrefsKeys.user);
    var user = UserModel.fromJson(json.decode(userJson));
    var role = user.userRole?.toUpperCase() ?? 'Patient';
    if (role == 'Patient'.toUpperCase()) {
      return EndPoints.getCompletedPatientAppointmentEndPoint;
    } else {
      return EndPoints.getCompletedDoctorAppointmentEndPoint;
    }
  }

  getAllReservationsCompleted() async {
    reservations.clear();
    emit(GetReservationsPatientLoading());
    var res = await reservationsRepo.getAllReservationsCompleted(getEndpoint());
    res.fold(
      (failure) {
        if (failure is OfflineFailure) {
          emit(GetReservationsPatientError(model: failure.model!));
        } else if (failure is ServerFailure) {
          emit(GetReservationsPatientError(model: failure.errorModel!));
        }
      },
      (reservations) {
        this.reservations = reservations;
        emit(GetReservationsPatientSuccess(reservations: reservations));
      },
    );
  }
}
