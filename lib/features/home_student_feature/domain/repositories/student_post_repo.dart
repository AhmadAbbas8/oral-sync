import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/features/home_student_feature/data/models/comment_model.dart';

import '../../data/models/Student_post_model.dart';

abstract class StudentPostRepo {
  Future<Either<Failure, List<StudentPostModel>>> getPostsPublic(int? page);

  Future<Either<Failure, ResponseModel>> createPost({
    required String content,
    required List<File> images,
  });

  Future<Either<Failure, ResponseModel>> archiveAndUnarchivePost(
      {required int postId});

  Future<Either<Failure, List<StudentPostModel>>> getAllPosts();

  Future<Either<Failure, List<StudentPostModel>>> getAllPostsArchived();

  Future<Either<Failure, StudentPostModel>> getPostByID({
    required int id,
  });

  Future<Either<Failure, CommentModel>> doComment({
    required int postId,
    required Map<String, dynamic> data,
  });
}
