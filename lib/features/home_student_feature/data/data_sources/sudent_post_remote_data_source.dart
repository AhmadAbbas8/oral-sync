import 'dart:developer';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/exception.dart';
import 'package:oralsync/core/network/api/api_consumer.dart';
import 'package:oralsync/core/utils/end_points.dart';
import 'package:oralsync/features/home_student_feature/data/models/Student_post_model.dart';

abstract class StudentPostRemoteDataSource {
  Future<ResponseModel> createPost({
    required String content,
    required List<File> images,
  });

  Future<List<StudentPostModel>> getAllPosts({
    required String content,
  });

  Future<StudentPostModel> getPostByID({
    required int id,
  });
}

class StudentPostRemoteDataSourceImpl implements StudentPostRemoteDataSource {
  final ApiConsumer apiConsumer;

  StudentPostRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<ResponseModel> createPost({
    required String content,
    required List<File> images,
  }) async {
    try {
      Response response = await apiConsumer.post(EndPoints.createPostEndPoint,
          queryParameters: {'title': 'title', 'content': content},
          isFromData: true,
          data: {
            'filecollection': [
              for (var val in images)
                await MultipartFile.fromFile(
                  val.path,
                  filename: val.path.split('/').last,
                )
            ],
          });
      if (response.statusCode == 200) {
        return ResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
            errorModel: ResponseModel(
                messageEn: 'Server Error', messageAr: 'مشكلة فى السيرفر'));
      }
    } on DioException catch (e) {
      throw ServerException(
          errorModel: ResponseModel.fromJson(e.response?.data));
    }
  }

  @override
  Future<List<StudentPostModel>> getAllPosts({required String content}) {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<StudentPostModel> getPostByID({required int id}) {
    // TODO: implement getPostByID
    throw UnimplementedError();
  }
}
