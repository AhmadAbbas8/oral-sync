part of 'free_paid_reservation_cubit.dart';

@immutable
abstract class FreePaidReservationState {}

class FreePaidReservationInitial extends FreePaidReservationState {}

class DoCommentPatientLoading extends FreePaidReservationState {}

class DoCommentPatientError extends FreePaidReservationState {
  final ResponseModel? model;

  DoCommentPatientError({required this.model});
}

class GetUserDataLoading extends FreePaidReservationState {}

class GetUserDataSuccess extends FreePaidReservationState {
  final UserModel user;
  final String userId;

  GetUserDataSuccess({required this.user, required this.userId});
}

class GetUserDataError extends FreePaidReservationState {
  final ResponseModel model;

  GetUserDataError({required this.model});
}

class DoCommentPatientSuccess extends FreePaidReservationState {}

class FetchFreePostsLoading extends FreePaidReservationState {}

class FetchFreePostsError extends FreePaidReservationState {
  final ResponseModel? model;

  FetchFreePostsError({required this.model});
}

class FetchFreePostsSuccess extends FreePaidReservationState {}

class LikeUnLikePostSuccess extends FreePaidReservationState {
  final ResponseModel responseModel;

  LikeUnLikePostSuccess({required this.responseModel});
}

class LikeUnLikePostError extends FreePaidReservationState {
  final ResponseModel? responseModel;

  LikeUnLikePostError({required this.responseModel});
}

class LikeUnLikePostLoading extends FreePaidReservationState {}
