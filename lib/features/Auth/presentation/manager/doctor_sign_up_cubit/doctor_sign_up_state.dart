part of 'doctor_sign_up_cubit.dart';

abstract class DoctorSignUpState extends Equatable {
  const DoctorSignUpState();

  @override
  List<Object> get props => [];
}

class DoctorSignUpInitial extends DoctorSignUpState {}

class DateChangedState extends DoctorSignUpState {}
class RegisterDoctorLoading extends DoctorSignUpState {}
class RegisterDoctorSuccess extends DoctorSignUpState {
  final RegisterBody model;

  const RegisterDoctorSuccess({required this.model});

  @override
  List<Object> get props => [model];
}
class RegisterDoctorError extends DoctorSignUpState {
  final String errMessage;

  const RegisterDoctorError({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class ChangePasswordVisibility extends DoctorSignUpState {
  final bool obscurePassword;

  ChangePasswordVisibility({required this.obscurePassword});

  @override
  // TODO: implement props
  List<Object> get props => [obscurePassword];
}
class GenderChangedState extends DoctorSignUpState {
  final bool isMale;

  const GenderChangedState({required this.isMale});

  @override
  // TODO: implement props
  List<Object> get props => [isMale];
}


class AddDoctorLoading extends DoctorSignUpState {}
class AddDoctorSuccess extends DoctorSignUpState {
  final String message;

  const AddDoctorSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
class AddDoctorError extends DoctorSignUpState {
  final String errMessage;

  const AddDoctorError({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}