import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/features/home_student_feature/domain/repositories/student_post_repo.dart';

import '../../../../core/error/error_model.dart';

class CreatePostUseCase {
  final StudentPostRepo studentPostRepo;

  CreatePostUseCase({required this.studentPostRepo});

  Future<Either<Failure, ResponseModel>> call({
    required String content,
    required List<File> images,
  }) async =>
      await studentPostRepo.createPost(content: content, images: images);
}
