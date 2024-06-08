import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/error_model.dart';

import '../../error/failure.dart';
import 'model/Notification_model.dart';
import 'model/ratings_model.dart';

abstract class ActionsRepo {
  Future<Either<Failure, List<NotificationModel>>> getNotifications();

  Future<Either<Failure, ResponseModel>> addLikeRemoveLike(int postId);

  Future<Either<Failure, ResponseModel>> createReserve({
    required String doctorId,
    required String status,
    required String location,
    required String dateAppointment,
    required String timeAppointment,
    required String patientNotes,
    required String doctorNotes,
    required String paymentMethod,
    required double fee,
  });

  Future<Either<Failure, List<RatingModel>>> getAllRates(String userId);
}
