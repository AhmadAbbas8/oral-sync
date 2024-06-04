import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/shared_data_layer/edit_profile_data_layer/edit_repo.dart';

import '../../../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../../Auth/data/models/user_model.dart';

part 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  DoctorProfileCubit(this._cacheStorage, this._editProfileRepo)
      : super(DoctorProfileInitial());
  final CacheStorage _cacheStorage;
  final EditProfileRepo _editProfileRepo;
  final picker = ServiceLocator.instance<ImagePicker>();

  UserModel getUserModel() {
    return UserModel.fromJson(
        jsonDecode(_cacheStorage.getData(key: SharedPrefsKeys.user)));
  }

  changeProfileImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    emit(ChangeDoctorProfileLoading());
    var res = await _editProfileRepo.updateImageProfile(
      data: {
        'formFile': await MultipartFile.fromFile(
          pickedImage.path,
          filename: pickedImage.path.split('/').last,
        )
      },
    );

    res.fold(
          (failure) {
        if (failure is ServerFailure) {
          emit(ChangeDoctorProfileError(model: failure.errorModel!));
        } else if (failure is OfflineFailure) {
          emit(ChangeDoctorProfileError(model: failure.model!));
        }
      },
          (model) {
        emit(ChangeDoctorProfileSuccess(image: model.profileImage ?? ''));
      },
    );
  }
}
