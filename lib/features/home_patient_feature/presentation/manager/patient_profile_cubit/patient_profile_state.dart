part of 'patient_profile_cubit.dart';

@immutable
abstract class PatientProfileState {}

class PatientProfileInitial extends PatientProfileState {}

class ChangePatientProfileError extends PatientProfileState {
  final ResponseModel? error;

  ChangePatientProfileError({this.error});
}

class ChangePatientProfileSuccess extends PatientProfileState {
  final String image;

  ChangePatientProfileSuccess({required this.image});
}

class ChangePatientProfileLoading extends PatientProfileState {}

class DateChangedPatientEditState extends PatientProfileState {}

class UpdatePatientDataLoading extends PatientProfileState {}

class UpdatePatientDataError extends PatientProfileState {
  final ResponseModel? responseModel;

  UpdatePatientDataError({required this.responseModel});
}

class UpdatePatientDataSuccess extends PatientProfileState {}

class GenderChangedState extends PatientProfileState {
  final bool isMale;

  GenderChangedState({required this.isMale});
}
