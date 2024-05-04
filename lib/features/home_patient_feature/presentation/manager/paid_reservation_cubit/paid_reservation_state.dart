part of 'paid_reservation_cubit.dart';

sealed class PaidReservationState extends Equatable {
  const PaidReservationState();

  @override
  List<Object> get props => [];
}

final class PaidReservationInitial extends PaidReservationState {}

final class FetchDoctorsLoading extends PaidReservationState {}

final class FetchDoctorsError extends PaidReservationState {}

final class FetchDoctorsSuccess extends PaidReservationState {}
