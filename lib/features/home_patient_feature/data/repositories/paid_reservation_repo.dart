import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../data_sources/paid_reservaion_local_data_source.dart';
import '../data_sources/paid_reservaion_remote_data_source.dart';
import '../models/DoctorModel.dart';

abstract class PaidReservationRepo {
  Future<Either<Failure, List<DoctorModel>>> getAllDoctors({
    double? minRate,
    String? insuranceCompany,
    String? governorate,
  });
}

class PaidReservationRepoImpl extends PaidReservationRepo {
  final PaidReservationLocalDataSource _localDataSource;
  final PaidReservationRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  PaidReservationRepoImpl({
    required PaidReservationLocalDataSource localDataSource,
    required PaidReservationRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, List<DoctorModel>>> getAllDoctors({
    double? minRate,
    String? insuranceCompany,
    String? governorate,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        var doctors = await _remoteDataSource.getAllDoctors(
          governorate: governorate,
          insuranceCompany: insuranceCompany,
          minRate: minRate,
        );
        await _localDataSource.cacheAllDoctors(doctors);
        return Right(doctors.cast<DoctorModel>());
      } on ServerException catch (ex) {
        return Left(ServerFailure(errorModel: ex.errorModel));
      }
    } else {
      try {
        var doctors = await _localDataSource.getAllDoctorsCached();
        return Right(doctors);
      } on EmptyCacheException {
        return Left(OfflineFailure());
      }
    }
  }
}
