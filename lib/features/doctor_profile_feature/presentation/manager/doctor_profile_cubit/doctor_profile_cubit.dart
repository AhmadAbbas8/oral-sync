import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';

import '../../../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../../Auth/data/models/user_model.dart';

part 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  DoctorProfileCubit(this._cacheStorage) : super(DoctorProfileInitial());
  final CacheStorage _cacheStorage;

  UserModel getUserModel() {
    return UserModel.fromJson(
        jsonDecode(_cacheStorage.getData(key: SharedPrefsKeys.user)));
  }
}
