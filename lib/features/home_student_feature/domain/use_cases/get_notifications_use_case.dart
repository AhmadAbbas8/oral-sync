import 'package:dartz/dartz.dart';
import 'package:oralsync/features/home_student_feature/domain/repositories/actions_repo.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/Notification_model.dart';

class GetNotificationsUseCase {
  final ActionsRepo _actionsRepo;

  GetNotificationsUseCase({required ActionsRepo actionsRepo})
      : _actionsRepo = actionsRepo;

  Future<Either<Failure, List<NotificationModel>>> call() async =>
      _actionsRepo.getNotifications();
}
