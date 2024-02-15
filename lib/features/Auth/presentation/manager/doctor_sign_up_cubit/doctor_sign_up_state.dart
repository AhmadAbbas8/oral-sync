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
  final UserModel user;

  const RegisterDoctorSuccess({required this.user});

  @override
  List<Object> get props => [user];
}
class RegisterDoctorError extends DoctorSignUpState {
  final ErrorModel? errorModel;

  const RegisterDoctorError({ this.errorModel});

@override
  // TODO: implement props
  List<Object> get props => super.props..add([errorModel]);
}

class ChangePasswordVisibility extends DoctorSignUpState {
  final bool obscurePassword;

  const ChangePasswordVisibility({required this.obscurePassword});

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
