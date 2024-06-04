part of 'doctor_profile_cubit.dart';

@immutable
sealed class DoctorProfileState {}

final class DoctorProfileInitial extends DoctorProfileState {}
final class DateChangedStateDoctor extends DoctorProfileState {}
final class UpdateDoctorDataLoading extends DoctorProfileState {}
final class UpdateDoctorDataSuccess extends DoctorProfileState {}
final class UpdateDoctorDataError extends DoctorProfileState {
  final ResponseModel? responseModel;

  UpdateDoctorDataError({required this.responseModel});
}
final class GenderChangedStateDoctor extends DoctorProfileState {
  final bool isMale;

  GenderChangedStateDoctor({required this.isMale});
}

final class ChangeDoctorProfileLoading extends DoctorProfileState {}

final class ChangeDoctorProfileSuccess extends DoctorProfileState {
  final String image;

  ChangeDoctorProfileSuccess({required this.image});
}

final class ChangeDoctorProfileError extends DoctorProfileState {
  final ResponseModel model;

  ChangeDoctorProfileError({required this.model});
}
