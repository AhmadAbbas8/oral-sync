import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../../../../core/cache_helper/cache_storage.dart';
import '../../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../../core/error/exception.dart';
import '../models/DoctorModel.dart';

abstract class PaidReservationLocalDataSource {
  Future<Unit> cacheAllDoctors(List<DoctorModel> doctors);

  Future<List<DoctorModel>> getAllDoctorsCached();
}

class PaidReservationLocalDataSourceImpl
    implements PaidReservationLocalDataSource {
  final CacheStorage _cacheStorage;

  PaidReservationLocalDataSourceImpl({
    required CacheStorage cacheStorage,
  }) : _cacheStorage = cacheStorage;

  @override
  Future<Unit> cacheAllDoctors(List<DoctorModel> doctors) async {
    List model = doctors.map((e) => e.toJson()).toList();
    await _cacheStorage.setData(
      key: SharedPrefsKeys.paidDoctorsCached,
      value: json.encode(model),
    );
    return Future.value(unit);
  }

  @override
  Future<List<DoctorModel>> getAllDoctorsCached() async {
    var doctorsJson =
        _cacheStorage.getData(key: SharedPrefsKeys.paidDoctorsCached);
    if (doctorsJson != null) {
      List doctors = json.decode(doctorsJson);
      return doctors.map((doctor) => DoctorModel.fromJson(doctor)).toList();
    } else {
      throw EmptyCacheException();
    }
  }
}
