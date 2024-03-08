import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/cache_helper/shared_prefs_keys.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';
import 'package:oralsync/features/home_student_feature/data/models/comment_model.dart';
import 'package:oralsync/features/home_student_feature/domain/use_cases/archive_and_unarchive_post_use_case.dart';
import 'package:oralsync/features/home_student_feature/domain/use_cases/do_comment_use_case.dart';
import 'package:oralsync/features/home_student_feature/domain/use_cases/get_all_posts_use_case.dart';

import '../../../../../core/error/failure.dart';
import '../../../data/models/Student_post_model.dart';

part 'home_student_state.dart';

class HomeStudentCubit extends Cubit<HomeStudentState> {
  HomeStudentCubit({
    required GetAllPostsStudentUseCase getAllPostsStudentUseCase,
    required DoCommentUseCase doCommentUseCase,
    required ArchiveAndUnArchivePostUseCase archiveAndUnArchivePostUseCase,
  })  : _getAllPostsStudentUseCase = getAllPostsStudentUseCase,
        _doCommentUseCase = doCommentUseCase,
        _archiveAndUnArchivePostUseCase = archiveAndUnArchivePostUseCase,
        super(HomeStudentInitial());
  final GetAllPostsStudentUseCase _getAllPostsStudentUseCase;
  final DoCommentUseCase _doCommentUseCase;
  final ArchiveAndUnArchivePostUseCase _archiveAndUnArchivePostUseCase;
  List<StudentPostModel> posts = [];
  TextEditingController commentController = TextEditingController();

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

  doComment(int postId, int index) async {
    if (commentController.text.isEmpty) return;

    emit(DoCommentLoading());
    var res = await _doCommentUseCase(
      title: 'title',
      content: commentController.text,
      postId: postId,
    );
    res.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(DoCommentError(model: failure.errorModel!));
        } else if (failure is OfflineFailure) {
          emit(DoCommentError(model: failure.model!));
        }
      },
      (r) {
        posts[index]
            .comments!
            .add(CommentModel(title: 'title', content: commentController.text));
        commentController.clear();
        emit(DoCommentSuccess());
      },
    );
  }

  archiveAndUnArchivePost(num postId) async {
    emit(ArchiveUnArchivePostLoading());
    var res = await _archiveAndUnArchivePostUseCase.call(postId.toInt());
    res.fold(
      (failure) {
        if (failure is OfflineFailure) {
          emit(ArchiveUnArchivePostError(model: failure.model!));
        } else if (failure is ServerFailure) {
          emit(ArchiveUnArchivePostError(model: failure.errorModel!));
        }
      },
      (model) {
        posts.removeWhere((element) => element.postId==postId);
        emit(ArchiveUnArchivePostSuccess(model: model));
      },
    );
  }

  @override
  Future<void> close() {
    commentController.dispose();
    return super.close();
  }
}
