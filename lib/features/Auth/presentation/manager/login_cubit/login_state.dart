part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class ChangePasswordVisibility extends LoginState {
  final bool obscurePassword;

  const ChangePasswordVisibility({required this.obscurePassword});
  @override
  // TODO: implement props
  List<Object?> get props => super.props..add(obscurePassword);
}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
final ErrorModel? errorModel ;

  const LoginError({ this.errorModel});

  @override
  // TODO: implement props
  List<Object?> get props => super.props..addAll([errorModel]);
}

class LoginSuccess extends LoginState {
  final UserModel user;

  const LoginSuccess({required this.user});

  @override
  List<Object?> get props => super.props..add(user);
}
