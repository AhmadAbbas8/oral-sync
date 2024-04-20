import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/error_model.dart';

import '../../error/failure.dart';
import 'model/Notification_model.dart';

abstract class ActionsRepo{
 Future<Either<Failure,List<NotificationModel>>> getNotifications();
 Future<Either<Failure,ResponseModel>> addLikeRemoveLike(int postId);

}
