import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/error_model.dart';
import '../../../../../core/error/failure.dart';
import '../../../data/models/DoctorModel.dart';
import '../../../data/repositories/paid_reservation_repo.dart';

part 'paid_reservation_state.dart';

class PaidReservationCubit extends Cubit<PaidReservationState> {
  final PaidReservationRepo _reservationRepo;

  PaidReservationCubit({
    required PaidReservationRepo reservationRepo,
  })  : _reservationRepo = reservationRepo,
        super(PaidReservationInitial());

  getAllDoctors({
    double? minRate,
    String? insuranceCompany,
    String? governorate,
  }) async {
    emit(FetchDoctorsLoading());
    var res = await _reservationRepo.getAllDoctors(
      minRate: minRate,
      insuranceCompany: insuranceCompany,
      governorate: governorate,
    );
    res.fold(
      (failure) {
        if (failure is OfflineFailure) {
          emit(FetchDoctorsError(failure: failure.model!));
        } else if (failure is ServerFailure) {
          emit(FetchDoctorsError(failure: failure.errorModel!));
        }
      },
      (doctors) => emit(FetchDoctorsSuccess(doctors: doctors)),
    );
  }
}
