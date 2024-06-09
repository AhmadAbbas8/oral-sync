import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/core/network/network_info.dart';
import 'package:oralsync/features/reservations_feature/data/remote_data_sources/reservations_remote_data_source.dart';

import '../models/reservation_model.dart';

abstract class ReservationsRepo {
  Future<Either<Failure, List<ReservationModel>>> getAllReservationsCompleted();
}

class ReservationsRepoImpl implements ReservationsRepo {
  final ReservationsRemoteDataSource reservationsRemoteDataSource;
  final NetworkInfo networkInfo;

  ReservationsRepoImpl({
    required this.reservationsRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ReservationModel>>>
      getAllReservationsCompleted() async {
    if (await networkInfo.isConnected) {
      try {
        var reservations =
            await reservationsRemoteDataSource.getAllReservationsCompleted();
        return Right(reservations);
      } on ServerFailure catch (ex) {
        return Left(ServerFailure(errorModel: ex.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
