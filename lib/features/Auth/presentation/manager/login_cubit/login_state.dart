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
  final String messageAr;
  final String messageEn;

  const LoginError({required this.messageAr, required this.messageEn});

  @override
  // TODO: implement props
  List<Object?> get props => super.props..addAll([messageAr, messageEn]);
}

class LoginSuccess extends LoginState {
  final User user;

  const LoginSuccess({required this.user});

  @override
  List<Object?> get props => super.props..add(user);
}
