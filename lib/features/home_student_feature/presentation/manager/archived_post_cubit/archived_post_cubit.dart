import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/cache_helper/cache_storage.dart';
import '../../../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../../../core/error/error_model.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../../Auth/data/models/user_model.dart';
import '../../../data/models/Student_post_model.dart';
import '../../../domain/use_cases/get_all_posts_archived_use_case.dart';

part 'archived_post_state.dart';

class ArchivedPostCubit extends Cubit<ArchivedPostState> {
  ArchivedPostCubit({required GetAllPostsArchivedUseCase postsArchivedUseCase})
      : _postsArchivedUseCase = postsArchivedUseCase,
        super(ArchivedPostInitial());

  final GetAllPostsArchivedUseCase _postsArchivedUseCase;
  List<StudentPostModel> posts = [];

  getAllPostsArchived() async {
    emit(GetAllArchivedPostsLoading());
    posts.clear();
    var res = await _postsArchivedUseCase.call();
    res.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(GetAllArchivedPostsError(model: failure.errorModel!));
        } else if (failure is OfflineFailure) {
          emit(GetAllArchivedPostsError(model: failure.model!));
        }
      },
      (posts) {
        this.posts = posts;
        emit(GetAllArchivedPostsSuccess(posts: posts));
      },
    );
  }

  var studentModel = UserModel.fromJson(json.decode(
      ServiceLocator.instance<CacheStorage>()
          .getData(key: SharedPrefsKeys.user)));

}
