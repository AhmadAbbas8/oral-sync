part of 'home_doctor_cubit.dart';

@immutable
sealed class HomeDoctorState {}

final class HomeDoctorInitial extends HomeDoctorState {}

final class UpdateReservationStatusDoctorLoading extends HomeDoctorState {}

final class UpdateReservationStatusDoctorError extends HomeDoctorState {
  final ResponseModel model;

  UpdateReservationStatusDoctorError({required this.model});
}

final class UpdateReservationStatusDoctorSuccess extends HomeDoctorState {
  final ResponseModel model;

  UpdateReservationStatusDoctorSuccess({required this.model});
}

final class GetPatientHistoryLoading extends HomeDoctorState {

}

final class GetPatientHistoryError extends HomeDoctorState {
  final ResponseModel model;

  GetPatientHistoryError({required this.model});
}

final class GetPatientHistorySuccess extends HomeDoctorState {
  final List<ReservationModel> histories;

  GetPatientHistorySuccess({required this.histories});
}

final class GetReservationsWaitingDoctorLoading extends HomeDoctorState {}

final class GetReservationsWaitingDoctorError extends HomeDoctorState {
  final ResponseModel model;

  GetReservationsWaitingDoctorError({required this.model});
}

final class GetReservationsWaitingDoctorSuccess extends HomeDoctorState {
  final List<ReservationModel> reservations;

  GetReservationsWaitingDoctorSuccess({required this.reservations});
}
