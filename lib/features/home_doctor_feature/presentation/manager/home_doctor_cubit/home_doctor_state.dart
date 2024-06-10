part of 'home_doctor_cubit.dart';

@immutable
sealed class HomeDoctorState {}

final class HomeDoctorInitial extends HomeDoctorState {}

final class GetReservationsWaitingDoctorLoading extends HomeDoctorState {}

final class GetReservationsWaitingDoctorError extends HomeDoctorState {
  final ResponseModel model;

  GetReservationsWaitingDoctorError({required this.model});
}

final class GetReservationsWaitingDoctorSuccess extends HomeDoctorState {
  final List<ReservationModel> reservations;

  GetReservationsWaitingDoctorSuccess({required this.reservations});
}
