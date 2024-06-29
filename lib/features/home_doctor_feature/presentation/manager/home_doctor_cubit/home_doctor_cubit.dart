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
  List<ReservationModel> patientHistory = [];

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
        this.reservations = reservations;
        emit(GetReservationsWaitingDoctorSuccess(reservations: reservations));
      },
    );
  }

  updateReservationStatus({
    required int index,
    required String status,
  }) async {
    emit(UpdateReservationStatusDoctorLoading());
    var res = await homeDoctorRepo.updateReservation(
      status: status,
      reservationId: reservations[index].id ?? 0,
      doctorNotes: 'Welcome to my clinic at any time, dear patient.',
    );
    res.fold((failure) {
      if (failure is OfflineFailure) {
        emit(UpdateReservationStatusDoctorError(model: failure.model!));
      } else if (failure is ServerFailure) {
        emit(UpdateReservationStatusDoctorError(model: failure.errorModel!));
      }
    }, (model) {
      if (status == 'Scheduled') {
        reservations[index].status = 'Scheduled';
      } else {
        reservations.removeAt(index);
      }
      emit(UpdateReservationStatusDoctorSuccess(model: model));
    });
  }

  Future<void> getPatientHistory(String patientId) async {
    patientHistory.clear();
    emit(GetPatientHistoryLoading());
    var res = await homeDoctorRepo.getPatientHistory(patientId: patientId);
    res.fold(
      (failure) {
        if (failure is OfflineFailure) {
          emit(GetPatientHistoryError(model: failure.model!));
        } else if (failure is ServerFailure) {
          emit(GetPatientHistoryError(model: failure.errorModel!));
        }
      },
      (histories) {
        patientHistory = histories;
        emit(GetPatientHistorySuccess(histories: histories));
      },
    );
  }
}
