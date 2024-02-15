import 'package:equatable/equatable.dart';
import 'package:oralsync/core/error/Error_model.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  final ErrorModel? errorModel;

  ServerFailure({ this.errorModel});
  @override
  // TODO: implement props
  List<Object?> get props => [errorModel];
}

class EmptyCacheFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
