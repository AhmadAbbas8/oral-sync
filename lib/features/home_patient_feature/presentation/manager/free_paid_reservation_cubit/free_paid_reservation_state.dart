part of 'free_paid_reservation_cubit.dart';

@immutable
abstract class FreePaidReservationState {}

class FreePaidReservationInitial extends FreePaidReservationState {}

class DoCommentPatientLoading extends FreePaidReservationState {}

class DoCommentPatientError extends FreePaidReservationState {
  final ResponseModel? model;

  DoCommentPatientError({required this.model});
}

class DoCommentPatientSuccess extends FreePaidReservationState {}

class FetchFreePostsLoading extends FreePaidReservationState {}

class FetchFreePostsError extends FreePaidReservationState {
  final ResponseModel? model;

  FetchFreePostsError({required this.model});
}

class FetchFreePostsSuccess extends FreePaidReservationState {}
