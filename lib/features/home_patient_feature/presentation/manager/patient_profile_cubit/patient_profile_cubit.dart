import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/shared_data_layer/edit_profile_data_layer/edit_repo.dart';

import '../../../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../../Auth/data/models/user_model.dart';

part 'patient_profile_state.dart';

class PatientProfileCubit extends Cubit<PatientProfileState> {
  PatientProfileCubit(this._editProfileRepo, this._cacheStorage)
      : super(PatientProfileInitial());
  final picker = ServiceLocator.instance<ImagePicker>();
  final EditProfileRepo _editProfileRepo;
  final CacheStorage _cacheStorage;

  UserModel getUserModel() {
    return UserModel.fromJson(
        jsonDecode(_cacheStorage.getData(key: SharedPrefsKeys.user)));
  }

  changeProfileImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    emit(ChangePatientProfileLoading());
    var res = await _editProfileRepo.updateImageProfile(data: {
      'formFile': await MultipartFile.fromFile(
        pickedImage.path,
        filename: pickedImage.path.split('/').last,
      )
    });

    res.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(ChangePatientProfileError(error: failure.errorModel));
        } else if (failure is OfflineFailure) {
          emit(ChangePatientProfileError(error: failure.model));
        }
      },
      (model) {
        emit(ChangePatientProfileSuccess(image: model.profileImage ?? ''));
      },
    );
  }
}
