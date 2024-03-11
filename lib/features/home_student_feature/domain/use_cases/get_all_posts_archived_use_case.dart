import 'package:dartz/dartz.dart';
import 'package:oralsync/features/home_student_feature/domain/repositories/student_post_repo.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/Student_post_model.dart';

class GetAllPostsArchivedUseCase {
  final StudentPostRepo _postRepo;

  GetAllPostsArchivedUseCase({
    required StudentPostRepo postRepo,
  }) : _postRepo = postRepo;

  Future<Either<Failure, List<StudentPostModel>>> call() async =>
      await _postRepo.getAllPostsArchived();
}
