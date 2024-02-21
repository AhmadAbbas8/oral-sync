import 'package:equatable/equatable.dart';

import 'package:oralsync/core/error/error_model.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  late final ResponseModel? model;

  OfflineFailure({ResponseModel? responseModel}){
    if(responseModel == null){
      model = ResponseModel(
        messageAr: 'تأكد من اتصال الانترنت',
        messageEn: 'Check your internet Connection',
      );
    }
  }

  @override
  List<Object?> get props => [model];
}

class ServerFailure extends Failure {
  final ResponseModel? errorModel;

  ServerFailure({this.errorModel});

  @override
  // TODO: implement props
  List<Object?> get props => [errorModel];
}

class EmptyCacheFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
