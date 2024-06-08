import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/network/network_info.dart';
import 'package:oralsync/core/shared_data_layer/actions_data_layer/actions_reomte_data_source.dart';
import 'package:oralsync/core/shared_data_layer/actions_data_layer/model/Notification_model.dart';
import 'package:oralsync/core/shared_data_layer/actions_data_layer/actions_repo.dart';
import 'package:oralsync/core/shared_data_layer/actions_data_layer/model/ratings_model.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';

class ActionsRepoImpl extends ActionsRepo {
  final ActionsRemoteDataSource _actionsRemoteDataSource;
  final NetworkInfo _networkInfo;

  ActionsRepoImpl({
    required ActionsRemoteDataSource actionsRemoteDataSource,
    required NetworkInfo networkInfo,
  })  : _actionsRemoteDataSource = actionsRemoteDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    if (await _networkInfo.isConnected) {
      try {
        List<NotificationModel> notifications =
            await _actionsRemoteDataSource.getNotifications();
        return Right(notifications);
      } on ServerException catch (ex) {
        return Left(ServerFailure(errorModel: ex.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> addLikeRemoveLike(int postId) async {
    if (await _networkInfo.isConnected) {
      try {
        var res = await _actionsRemoteDataSource.addLikeRemoveLike(postId);
        return Right(res);
      } on ServerException catch (ex) {
        return Left(ServerFailure(errorModel: ex.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> createReserve({
    required String doctorId,
    required String status,
    required String location,
    required String dateAppointment,
    required String timeAppointment,
    required String patientNotes,
    required String doctorNotes,
    required String paymentMethod,
    required double fee,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        var data = <String, dynamic>{
          "doctorId": doctorId,
          "status": status,
          "location": location,
          "dateAppointment": dateAppointment,
          "timeAppointment": timeAppointment,
          "patientNotes": patientNotes,
          "doctorNotes": doctorNotes,
          "paymentMethod": paymentMethod,
          "fee": fee,
        };
        var res = await _actionsRemoteDataSource.createReserve(data);
        return Right(res);
      } on ServerException catch (ex) {
        return Left(ServerFailure(errorModel: ex.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure,    List<RatingModel> >> getAllRates(String userId) async {
    if (await _networkInfo.isConnected) {
      try {
        var res = await _actionsRemoteDataSource.getAllRates(userId);
        return Right(res);
      } on ServerException catch (ex) {
        return Left(ServerFailure(errorModel: ex.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
