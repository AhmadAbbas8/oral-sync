import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/core/network/network_info.dart';
import 'package:oralsync/features/home_doctor_feature/presentation/data/data_sources/home_doctor_remote_data_source.dart';

import '../../../../../core/error/error_model.dart';
import '../../../../../core/error/exception.dart';
import '../../../../reservations_feature/data/models/reservation_model.dart';

abstract class HomeDoctorRepo {
  Future<Either<Failure, List<ReservationModel>>> getAllReservationsForDoctor();

  Future<Either<Failure, ResponseModel>> updateReservation({
    required String status,
    required int reservationId,
    required String doctorNotes,
  });

  Future<Either<Failure,List<ReservationModel>>> getPatientHistory({required String patientId});
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

  @override
  Future<Either<Failure, ResponseModel>> updateReservation({
    required String status,
    required int reservationId,
    required String doctorNotes,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        var res = await dataSource.updateReservation(
          status: status,
          reservationId: reservationId,
          doctorNotes: doctorNotes,
        );
        return Right(res);
      } on ServerException catch (ex) {
        return Left(ServerFailure(errorModel: ex.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<ReservationModel>>> getPatientHistory({required String patientId})async {
    if (await networkInfo.isConnected) {
      try {
        var reservations = await dataSource.getPatientHistory(patientId: patientId);
        return Right(reservations);
      } on ServerException catch (ex) {
        return Left(ServerFailure(errorModel: ex.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
