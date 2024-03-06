import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/cache_helper/shared_prefs_keys.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';
import 'package:oralsync/features/home_student_feature/domain/use_cases/get_all_posts_use_case.dart';

import '../../../../../core/error/failure.dart';
import '../../../data/models/Student_post_model.dart';

part 'home_student_state.dart';

class HomeStudentCubit extends Cubit<HomeStudentState> {
  HomeStudentCubit({required this.getAllPostsStudentUseCase})
      : super(HomeStudentInitial());
  final GetAllPostsStudentUseCase getAllPostsStudentUseCase;
  List<StudentPostModel> posts = [];

  var studentModel = UserModel.fromJson(json.decode(
      ServiceLocator.instance<CacheStorage>()
          .getData(key: SharedPrefsKeys.user)));

  getAllPosts() async {
    posts.clear();
    emit(GetAllPostsLoading());
    var response = await getAllPostsStudentUseCase.call();
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

}
