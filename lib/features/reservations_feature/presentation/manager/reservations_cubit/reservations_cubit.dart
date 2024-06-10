import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/features/reservations_feature/data/repo/reservations_repo.dart';

import '../../../data/models/reservation_model.dart';

part 'reservations_state.dart';

class ReservationsCubit extends Cubit<ReservationsState> {
  ReservationsCubit({
    required this.reservationsRepo,
  }) : super(ReservationsInitial());
  final ReservationsRepo reservationsRepo;
  List<ReservationModel> reservations = [];

  getAllReservationsCompleted() async {
    reservations.clear();
    emit(GetReservationsPatientLoading());
    var res = await reservationsRepo.getAllReservationsCompleted();
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
