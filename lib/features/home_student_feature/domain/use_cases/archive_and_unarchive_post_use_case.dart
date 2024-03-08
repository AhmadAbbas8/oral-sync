import 'package:dartz/dartz.dart';

import '../../../../core/error/error_model.dart';
import '../../../../core/error/failure.dart';
import '../repositories/student_post_repo.dart';

class ArchiveAndUnArchivePostUseCase {
  final StudentPostRepo _postRepo;

  ArchiveAndUnArchivePostUseCase({required StudentPostRepo postRepo})
      : _postRepo = postRepo;

  Future<Either<Failure, ResponseModel>> call(int postId) async =>
      await _postRepo.archiveAndUnarchivePost(postId: postId);
}
