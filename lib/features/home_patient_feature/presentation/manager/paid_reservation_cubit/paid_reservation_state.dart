part of 'paid_reservation_cubit.dart';

sealed class PaidReservationState extends Equatable {
  const PaidReservationState();

  @override
  List<Object> get props => [];
}

final class PaidReservationInitial extends PaidReservationState {}

final class FetchDoctorsLoading extends PaidReservationState {}

final class FetchDoctorsError extends PaidReservationState {
  final ResponseModel failure;

  const FetchDoctorsError({required this.failure});

  @override
  List<Object> get props => [failure];
}

final class FetchDoctorsSuccess extends PaidReservationState {
  final List<DoctorModel> doctors;

  const FetchDoctorsSuccess({required this.doctors});

  @override
  List<Object> get props => [doctors];
}
