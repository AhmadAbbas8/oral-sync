import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/cache_helper/shared_prefs_keys.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';
import 'package:oralsync/features/home_student_feature/domain/use_cases/do_comment_use_case.dart';
import 'package:oralsync/features/home_student_feature/domain/use_cases/get_all_posts_use_case.dart';

import '../../../../../core/error/failure.dart';
import '../../../data/models/Student_post_model.dart';

part 'home_student_state.dart';

class HomeStudentCubit extends Cubit<HomeStudentState> {
  HomeStudentCubit({
    required GetAllPostsStudentUseCase getAllPostsStudentUseCase,
    required DoCommentUseCase doCommentUseCase,
  })  : _getAllPostsStudentUseCase = getAllPostsStudentUseCase,
        _doCommentUseCase = doCommentUseCase,
        super(HomeStudentInitial());
  final GetAllPostsStudentUseCase _getAllPostsStudentUseCase;
  final DoCommentUseCase _doCommentUseCase;
  List<StudentPostModel> posts = [];

  var studentModel = UserModel.fromJson(json.decode(
      ServiceLocator.instance<CacheStorage>()
          .getData(key: SharedPrefsKeys.user)));

  getAllPosts() async {
    posts.clear();
    emit(GetAllPostsLoading());
    var response = await _getAllPostsStudentUseCase.call();
    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(GetAllPostsError(responseModel: failure.errorModel));
        } else if (failure is OfflineFailure) {
          emit(GetAllPostsError(responseModel: failure.model));
        }
      },
      (posts) {
        this.posts = posts;
        emit(GetAllPostsSuccess(posts: posts));
      },
    );
  }

  doComment(int postId) async {
    var res = await _doCommentUseCase(
      title: 'title',
      content: 'Hi Bro I am Ahmed Abbas',
      postId: postId,
    );
  }
}
