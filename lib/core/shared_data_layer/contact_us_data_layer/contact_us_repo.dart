import 'package:dartz/dartz.dart';

import '../../error/error_model.dart';
import '../../error/exception.dart';
import '../../error/failure.dart';
import '../../network/network_info.dart';
import 'contact_us_data_source.dart';

abstract class ContactUsRepo {
  Future<Either<Failure, ResponseModel>> sendFeedback({
    required String message,
    String? name,
    String? phoneNumber,
    String? email,
  });
}

class ContactUsRepoImpl extends ContactUsRepo {
  final ContactUsDataSource _dataSource;
  final NetworkInfo _networkInfo;

  ContactUsRepoImpl({
    required ContactUsDataSource dataSource,
    required NetworkInfo networkInfo,
  })  : _dataSource = dataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, ResponseModel>> sendFeedback({
    required String message,
    String? name,
    String? phoneNumber,
    String? email,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        var model = await _dataSource.sendFeedback(
          message: message,
          name: name,
          email: email,
          phoneNumber: phoneNumber,
        );
        return Right(model);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorModel: e.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
