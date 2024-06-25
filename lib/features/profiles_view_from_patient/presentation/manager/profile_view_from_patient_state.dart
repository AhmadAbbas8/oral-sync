part of 'profile_view_from_patient_cubit.dart';

@immutable
sealed class ProfileViewFromPatientState {}

final class ProfileViewFromPatientInitial extends ProfileViewFromPatientState {}

final class StartNewConversationLoading extends ProfileViewFromPatientState {}

final class StartNewConversationError extends ProfileViewFromPatientState {
  final ResponseModel model;

  StartNewConversationError({required this.model});

}

final class StartNewConversationSuccess extends ProfileViewFromPatientState {
  final ResponseModel model;

  StartNewConversationSuccess({required this.model});
}

final class GetAllRatesLoading extends ProfileViewFromPatientState {}

final class GetAllRatesError extends ProfileViewFromPatientState {
  final ResponseModel model;

  GetAllRatesError({required this.model});
}

final class GetAllRatesSuccess extends ProfileViewFromPatientState {
  final List<RatingModel> rates;

  GetAllRatesSuccess({required this.rates});
}

final class CreateReserveLoading extends ProfileViewFromPatientState {}

final class CreateReserveError extends ProfileViewFromPatientState {
  final ResponseModel responseModel;

  CreateReserveError({required this.responseModel});
}

final class CreateReserveSuccess extends ProfileViewFromPatientState {
  final ResponseModel responseModel;

  CreateReserveSuccess({required this.responseModel});
}
