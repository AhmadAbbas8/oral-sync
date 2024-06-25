import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/features/settings_feature/data/repo/settings_repo.dart';

part 'settings__state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required SettingsRepo settingsRepo,
  })  : _repo = settingsRepo,
        super(SettingsInitial());
  final SettingsRepo _repo;
  final newPasswordController = TextEditingController();
  bool obscurePassword = true;
  final formKey = GlobalKey<FormState>();

  toggleVisibilityPassword() {
    obscurePassword = !obscurePassword;
    emit(ChangePasswordVisibilityState(obscurePassword: obscurePassword));
  }

  Future<void> convertStudentAccountToDoctorAccount(String userId) async {
    emit(ConvertAccountLoading());
    var res = await _repo.convertStudentAccountToDoctorAccount(userId: userId);
    res.fold(
      (failure) {
        if (failure is OfflineFailure) {
          emit(ConvertAccountError(model: failure.model!));
        } else if (failure is ServerFailure) {
          emit(ConvertAccountError(model: failure.errorModel!));
        }
      },
      (model) => emit(ConvertAccountSuccess(model: model)),
    );
  }

  Future<void> updateUserPassword() async {
    emit(UpdateUserPasswordLoading());
    var res =
        await _repo.updateUserPassword(newPassword: newPasswordController.text);
    res.fold(
      (failure) {
        if (failure is OfflineFailure) {
          emit(UpdateUserPasswordError(model: failure.model!));
        } else if (failure is ServerFailure) {
          emit(UpdateUserPasswordError(model: failure.errorModel!));
        }
      },
      (model) {
        newPasswordController.clear();
        emit(UpdateUserPasswordSuccess(model: model));
      },
    );
  }

  @override
  Future<void> close() {
    newPasswordController.dispose();
    return super.close();
  }
}
