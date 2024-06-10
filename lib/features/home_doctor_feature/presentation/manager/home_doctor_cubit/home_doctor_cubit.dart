import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/features/home_doctor_feature/presentation/data/repo/home_doctor_repo.dart';

import '../../../../reservations_feature/data/models/reservation_model.dart';

part 'home_doctor_state.dart';

class HomeDoctorCubit extends Cubit<HomeDoctorState> {
  HomeDoctorCubit({required this.homeDoctorRepo}) : super(HomeDoctorInitial());
  final HomeDoctorRepo homeDoctorRepo;
  List<ReservationModel> reservations = [];

  getWaitingReservationsForDoctor() async {
    reservations.clear();
    emit(GetReservationsWaitingDoctorLoading());
    var res = await homeDoctorRepo.getAllReservationsForDoctor();
    res.fold(
      (failure) {
        if (failure is OfflineFailure) {
          emit(GetReservationsWaitingDoctorError(model: failure.model!));
        } else if (failure is ServerFailure) {
          emit(GetReservationsWaitingDoctorError(model: failure.errorModel!));
        }
      },
      (reservations) {
     this.   reservations = reservations;
        emit(GetReservationsWaitingDoctorSuccess(reservations: reservations));
      },
    );
  }
}
