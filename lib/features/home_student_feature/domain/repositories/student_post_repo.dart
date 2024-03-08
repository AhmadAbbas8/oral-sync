import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/failure.dart';

import '../../data/models/Student_post_model.dart';

abstract class StudentPostRepo {
  Future<Either<Failure, ResponseModel>> createPost({
    required String content,
    required List<File> images,
  });

  Future<Either<Failure, ResponseModel>> archiveAndUnarchivePost({required int postId});

  Future<Either<Failure, List<StudentPostModel>>> getAllPosts();

  Future<Either<Failure, StudentPostModel>> getPostByID({
    required int id,
  });

  Future<Either<Failure, ResponseModel>> doComment({
    required int postId,
    required Map<String, dynamic> data,
  });
}
