import 'package:oralsync/core/error/error_model.dart';

class ServerException implements Exception {
  final ErrorModel? errorModel;

  ServerException({ this.errorModel});
}

class OfflineException implements Exception {}
class CommonServerException implements Exception {}

class EmptyCacheException implements Exception {}
