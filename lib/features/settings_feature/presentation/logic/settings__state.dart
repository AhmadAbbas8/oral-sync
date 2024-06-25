part of 'settings__cubit.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}

final class ChangePasswordVisibilityState extends SettingsState {
  final bool obscurePassword;

  const ChangePasswordVisibilityState({required this.obscurePassword});

  @override
  List<Object> get props => [obscurePassword];
}

final class UpdateUserPasswordLoading extends SettingsState {}

final class UpdateUserPasswordError extends SettingsState {
  final ResponseModel model;

  const UpdateUserPasswordError({required this.model});

  @override
  List<Object> get props => [model];
}

final class UpdateUserPasswordSuccess extends SettingsState {
  final ResponseModel model;

  const UpdateUserPasswordSuccess({required this.model});

  @override
  List<Object> get props => [model];
}

final class ConvertAccountLoading extends SettingsState {}

final class ConvertAccountError extends SettingsState {
  final ResponseModel model;

  const ConvertAccountError({required this.model});

  @override
  List<Object> get props => [model];
}

final class ConvertAccountSuccess extends SettingsState {
  final ResponseModel model;

  const ConvertAccountSuccess({required this.model});

  @override
  List<Object> get props => [model];
}
