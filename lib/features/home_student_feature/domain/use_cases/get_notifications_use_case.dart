import 'package:dartz/dartz.dart';
import 'package:oralsync/core/shared_data_layer/actions_data_layer/actions_repo.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared_data_layer/actions_data_layer/model/Notification_model.dart';

class GetNotificationsUseCase {
  final ActionsRepo _actionsRepo;

  GetNotificationsUseCase({required ActionsRepo actionsRepo})
      : _actionsRepo = actionsRepo;

  Future<Either<Failure, List<NotificationModel>>> call() async =>
      _actionsRepo.getNotifications();
}
