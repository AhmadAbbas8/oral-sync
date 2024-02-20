part of 'patient_sign_up_cubit.dart';

abstract class PatientSignUpState extends Equatable {
  const PatientSignUpState();

  @override
  List<Object> get props => [];
}

class PatientSignUpInitial extends PatientSignUpState {}

class RegisterPatientLoading extends PatientSignUpState {}

class DateChangedState extends PatientSignUpState {}

class RegisterPatientError extends PatientSignUpState {
  final ResponseModel? errorModel;

  const RegisterPatientError({this.errorModel});

  @override
// TODO: implement props
  List<Object> get props => super.props..add([errorModel]);
}

class RegisterPatientSuccess extends PatientSignUpState {
  final UserModel model;

  const RegisterPatientSuccess({required this.model});

  @override
  List<Object> get props => [model];
}

class GenderChangedState extends PatientSignUpState {
  final bool isMale;

  const GenderChangedState({required this.isMale});

  @override
  List<Object> get props => [isMale];
}

class ChangePasswordVisibility extends PatientSignUpState {
  final bool obscurePassword;

  const ChangePasswordVisibility({required this.obscurePassword});

  @override
  List<Object> get props => [obscurePassword];
}

class AddedPatientLoading extends PatientSignUpState {}

class AddedPatientSuccess extends PatientSignUpState {
  final String message;

  const AddedPatientSuccess({required this.message});
}

class AddedPatientError extends PatientSignUpState {
  final String errMessage;

  const AddedPatientError({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
