part of 'student_sign_up_cubit.dart';

abstract class StudentSignUpState extends Equatable {
  const StudentSignUpState();

  @override
  List<Object> get props => [];
}

class StudentSignUpInitial extends StudentSignUpState {}
class DateChangedState extends StudentSignUpState {}
class ChangePasswordVisibility extends StudentSignUpState {
  final bool obscurePassword;

  ChangePasswordVisibility({required this.obscurePassword});

  @override
  // TODO: implement props
  List<Object> get props => [obscurePassword];
}

class GenderChangedState extends StudentSignUpState {
  final bool isMale;

  const GenderChangedState({required this.isMale});

  @override
  // TODO: implement props
  List<Object> get props => [isMale];
}


class RegisterStudentLoading extends StudentSignUpState {}
class RegisterStudentSuccess extends StudentSignUpState {
  final UserModel model;

  const RegisterStudentSuccess({required this.model});

  @override
  List<Object> get props => [model];
}
class RegisterStudentError extends StudentSignUpState {
  final ErrorModel? errorModel;

  const RegisterStudentError({ this.errorModel});

  @override
  List<Object> get props => super.props..add([errorModel]);
}


class AddStudentLoading extends StudentSignUpState {}
class AddStudentSuccess extends StudentSignUpState {
  final String message;

  const AddStudentSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
class AddStudentError extends StudentSignUpState {
  final String errMessage;

  const AddStudentError({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}