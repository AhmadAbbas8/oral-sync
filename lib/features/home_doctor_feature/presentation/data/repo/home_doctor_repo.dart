import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/core/network/network_info.dart';
import 'package:oralsync/features/home_doctor_feature/presentation/data/data_sources/home_doctor_remote_data_source.dart';

import '../../../../../core/error/exception.dart';
import '../../../../reservations_feature/data/models/reservation_model.dart';

abstract class HomeDoctorRepo {
  Future<Either<Failure, List<ReservationModel>>> getAllReservationsForDoctor();
}

class HomeDoctorRepoImpl implements HomeDoctorRepo {
  final NetworkInfo networkInfo;
  final HomeDoctorRemoteDataSource dataSource;

  const HomeDoctorRepoImpl(
      {required this.networkInfo, required this.dataSource});

  @override
  Future<Either<Failure, List<ReservationModel>>>
      getAllReservationsForDoctor() async {
    if (await networkInfo.isConnected) {
      try {
        var reservations = await dataSource.getAllReservationsForDoctor();
        return Right(reservations);
      } on ServerException catch (ex) {
        return Left(ServerFailure(errorModel: ex.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
