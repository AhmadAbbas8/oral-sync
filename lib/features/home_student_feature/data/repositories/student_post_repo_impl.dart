import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:oralsync/features/home_student_feature/data/models/comment_model.dart';

import '../../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../../core/error/error_model.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/student_post_repo.dart';
import '../data_sources/student_post_local_data_source.dart';
import '../data_sources/sudent_post_remote_data_source.dart';
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
        var localPosts = await studentPostLocalDataSource
            .getCachedPosts(SharedPrefsKeys.studentPostsCached);
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

  @override
  Future<Either<Failure,CommentModel>> doComment({
    required int postId,
    required Map<String, dynamic> data,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        var model = await studentPostRemoteDataSource.doComment(postId, data);

        return Right(model);
      } on ServerException catch (ex) {
        return Left(ServerFailure(errorModel: ex.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> archiveAndUnarchivePost(
      {required int postId}) async {
    if (await networkInfo.isConnected) {
      try {
        var model = await studentPostRemoteDataSource.archiveAndUnarchivePost(
            id: postId);

        return Right(model);
      } on ServerException catch (ex) {
        return Left(ServerFailure(errorModel: ex.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<StudentPostModel>>> getAllPostsArchived() async {
    if (await networkInfo.isConnected) {
      try {
        var posts = await studentPostRemoteDataSource.getAllPostsArchived();
        await studentPostLocalDataSource.cachedPostsArchived(posts);
        return Right(posts.cast<StudentPostModel>());
      } on ServerException catch (ex) {
        return Left(ServerFailure(errorModel: ex.errorModel));
      }
    } else {
      try {
        var localPosts = await studentPostLocalDataSource
            .getCachedPosts(SharedPrefsKeys.studentPostsArchivedCached);
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(OfflineFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<StudentPostModel>>> getPostsPublic(
      int? page) async {
    if (await networkInfo.isConnected) {
      try {
        var posts = await studentPostRemoteDataSource.getPostsPublic(page);
        await studentPostLocalDataSource.cachedPostsArchived(posts);
        return Right(posts.cast<StudentPostModel>());
      } on ServerException catch (ex) {
        return Left(ServerFailure(errorModel: ex.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
