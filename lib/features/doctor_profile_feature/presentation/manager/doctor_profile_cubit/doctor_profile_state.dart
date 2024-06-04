part of 'doctor_profile_cubit.dart';

@immutable
sealed class DoctorProfileState {}

final class DoctorProfileInitial extends DoctorProfileState {}

final class ChangeDoctorProfileLoading extends DoctorProfileState {}

final class ChangeDoctorProfileSuccess extends DoctorProfileState {
  final String image;

  ChangeDoctorProfileSuccess({required this.image});
}

final class ChangeDoctorProfileError extends DoctorProfileState {
  final ResponseModel model;

  ChangeDoctorProfileError({required this.model});
}
