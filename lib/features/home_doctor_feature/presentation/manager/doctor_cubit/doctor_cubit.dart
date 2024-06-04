import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/cache_helper/cache_storage.dart';
import '../../../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../../Auth/data/models/user_model.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorInitial());
  var doctorModel = UserModel.fromJson(json.decode(
      ServiceLocator.instance<CacheStorage>()
          .getData(key: SharedPrefsKeys.user)));
}
