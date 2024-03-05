import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/Notification_model.dart';

abstract class ActionsRepo{
 Future<Either<Failure,List<NotificationModel>>> getNotifications();
}
