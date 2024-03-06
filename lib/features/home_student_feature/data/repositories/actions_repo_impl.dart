import 'package:dartz/dartz.dart';
import 'package:oralsync/core/network/network_info.dart';
import 'package:oralsync/features/home_student_feature/data/data_sources/actions_reomte_data_source.dart';
import 'package:oralsync/features/home_student_feature/data/models/Notification_model.dart';
import 'package:oralsync/features/home_student_feature/domain/repositories/actions_repo.dart';

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
}
