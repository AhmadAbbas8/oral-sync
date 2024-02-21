import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/exception.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/core/network/network_info.dart';
import 'package:oralsync/features/home_student_feature/data/data_sources/sudent_post_remote_data_source.dart';

import 'package:oralsync/features/home_student_feature/domain/repositories/student_post_repo.dart';

import '../data_sources/student_post_local_data_source.dart';
import '../models/Student_post_model.dart';

class StudentPostRepoImpl implements StudentPostRepo {
  final StudentPostRemoteDataSource studentPostRemoteDataSource;
  final NetworkInfo networkInfo;
  final StudentPostLocalDataSource studentPostLocalDataSource;

  StudentPostRepoImpl({
    required this.studentPostLocalDataSource,
    required this.networkInfo,
    required this.studentPostRemoteDataSource,
  });

  @override
  Future<Either<Failure, ResponseModel>> createPost({
    required String content,
    required List<File> images,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        ResponseModel model = await studentPostRemoteDataSource.createPost(
            content: content, images: images);
        return Right(model);
      } on ServerException catch (ex) {
        return Left(ServerFailure(errorModel: ex.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<StudentPostModel>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        var posts = await studentPostRemoteDataSource.getAllPosts();
        await studentPostLocalDataSource.cachedPosts(posts);
        return Right(posts.cast<StudentPostModel>());
      } on ServerException catch (ex) {
        return Left(ServerFailure(errorModel: ex.errorModel));
      }
    } else {
      try {
        var localPosts = await studentPostLocalDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(OfflineFailure());
      }
    }
  }

  @override
  Future<Either<Failure, StudentPostModel>> getPostByID({required int id}) {
    // TODO: implement getPostByID
    throw UnimplementedError();
  }
}
