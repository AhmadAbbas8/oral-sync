import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/exception.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/core/network/network_info.dart';
import 'package:oralsync/features/home_student_feature/data/data_sources/sudent_post_remote_data_source.dart';
import 'package:oralsync/features/home_student_feature/data/models/student_post_model.dart';
import 'package:oralsync/features/home_student_feature/domain/repositories/student_post_repo.dart';

class StudentPostRepoImpl implements StudentPostRepo {
  final StudentPostRemoteDataSource studentPostRemoteDataSource;
  final NetworkInfo networkInfo;

  StudentPostRepoImpl({
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
        ResponseModel model =
            await studentPostRemoteDataSource.createPost(content: content,images: images);
        return Right(model);
      } on ServerException catch (ex) {
        return Left(ServerFailure(errorModel: ex.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<StudentPostModel>>> getAllPosts(
      {required String content}) {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, StudentPostModel>> getPostByID({required int id}) {
    // TODO: implement getPostByID
    throw UnimplementedError();
  }
}
