import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/exception.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/core/network/network_info.dart';
import 'package:oralsync/features/messages_feature/data/data_sources/messages_remote_data_source.dart';

import '../models/start_message_model.dart';

abstract class MessagesRepo {
  Future<Either<Failure, List<StartMessageModel>>> getAllStartMessages();

  Future<Either<Failure, ResponseModel>> startNewConversation({
    required String receiverId,
  });
}

class MessagesRepoImpl implements MessagesRepo {
  final MessagesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MessagesRepoImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<StartMessageModel>>> getAllStartMessages() async {
    if (await networkInfo.isConnected) {
      try {
        var res = await remoteDataSource.getAllStartMessages();
        return Right(res);
      } on ServerException catch (ex) {
        return Left(ServerFailure(errorModel: ex.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> startNewConversation({
    required String receiverId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        var res = await remoteDataSource.startMessage(
          receiverId: receiverId,
        );
        return Right(res);
      } on ServerException catch (ex) {
        return Left(ServerFailure(errorModel: ex.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
