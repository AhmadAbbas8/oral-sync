import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/cache_helper/cache_storage.dart';
import '../../../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../../Auth/data/models/user_model.dart';

part 'home_patient_state.dart';

class HomePatientCubit extends Cubit<HomePatientState> {
  HomePatientCubit() : super(HomePatientInitial());

  var patientModel = UserModel.fromJson(json.decode(
      ServiceLocator.instance<CacheStorage>()
          .getData(key: SharedPrefsKeys.user)));
}
