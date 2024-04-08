part of 'home_patient_cubit.dart';

abstract class HomePatientState {}

class HomePatientInitial extends HomePatientState {}

class ChangeNavBarIndexPatient extends HomePatientState {
  final int index;

  ChangeNavBarIndexPatient({required this.index});
}

class FetchNotificationPatientLoading extends HomePatientState {}

class FetchNotificationPatientError extends HomePatientState {
  final ResponseModel? responseModel;

  FetchNotificationPatientError({required this.responseModel});
}

class FetchNotificationPatientSuccess extends HomePatientState {}
