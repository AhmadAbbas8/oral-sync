import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/features/home_student_feature/data/models/student_post_model.dart';

abstract class StudentPostRepo {
  Future<Either<Failure, ResponseModel>> createPost({
    required String content,
    required List<File> images,
  });

  Future<Either<Failure, List<StudentPostModel>>> getAllPosts({
    required String content,
  });

  Future<Either<Failure, StudentPostModel>> getPostByID({
    required int id,
  });
}
