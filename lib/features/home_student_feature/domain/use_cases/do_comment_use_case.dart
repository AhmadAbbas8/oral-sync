import 'package:dartz/dartz.dart';

import '../../../../core/error/error_model.dart';
import '../../../../core/error/failure.dart';
import '../repositories/student_post_repo.dart';

class DoCommentUseCase {
  final StudentPostRepo _postRepo;

  DoCommentUseCase({
    required StudentPostRepo postRepo,
  }) : _postRepo = postRepo;

  Future<Either<Failure, ResponseModel>> call({
    required int postId,
    required String title,
    required String content,
  }) async =>
      await _postRepo.doComment(
        postId: postId,
        data: {
          "title": title,
          "content": content,
          "postId": postId,
        },
      );
}
