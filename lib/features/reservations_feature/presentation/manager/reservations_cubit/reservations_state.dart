part of 'reservations_cubit.dart';

@immutable
sealed class ReservationsState {}

final class ReservationsInitial extends ReservationsState {}

final class GetReservationsPatientLoading extends ReservationsState {}

final class GetReservationsPatientError extends ReservationsState {
  final ResponseModel model;

  GetReservationsPatientError({required this.model});
}

final class GetReservationsPatientSuccess extends ReservationsState {
  final List<ReservationModel> reservations;

  GetReservationsPatientSuccess({required this.reservations});
}
