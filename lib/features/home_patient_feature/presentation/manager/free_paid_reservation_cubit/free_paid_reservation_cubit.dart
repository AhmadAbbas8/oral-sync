import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/features/home_student_feature/data/models/Student_post_model.dart';
import 'package:oralsync/features/home_student_feature/domain/repositories/student_post_repo.dart';
import 'package:oralsync/features/home_student_feature/domain/use_cases/do_comment_use_case.dart';

import '../../../../../core/error/error_model.dart';
import '../../../../home_student_feature/data/models/comment_model.dart';

part 'free_paid_reservation_state.dart';

class FreePaidReservationCubit extends Cubit<FreePaidReservationState> {
  FreePaidReservationCubit(
      {required StudentPostRepo studentPostRepo,
      required DoCommentUseCase doCommentUseCase})
      : _studentPostRepo = studentPostRepo,
        _doCommentUseCase = doCommentUseCase,
        super(FreePaidReservationInitial());
  final DoCommentUseCase _doCommentUseCase;
  final StudentPostRepo _studentPostRepo;
  bool reachMax = false;
  int page = 1;
  List<StudentPostModel> freePosts = [];
  final commentController = TextEditingController();

  getFreePosts() async {
    if (reachMax) {
      return;
    }
    emit(FetchFreePostsLoading());
    var res = await _studentPostRepo.getPostsPublic(page);
    res.fold((failure) {
      if (failure is OfflineFailure) {
        emit(FetchFreePostsError(model: failure.model));
      } else if (failure is ServerFailure) {
        emit(FetchFreePostsError(model: failure.errorModel));
      }
    }, (posts) {
      if (posts.isEmpty) {
        reachMax = true;
      }

      for (var val in posts) {
        freePosts.add(val);
      }
      page++;
      emit(FetchFreePostsSuccess());
    });
  }

  Future<void> onRefresh() async {
    freePosts.clear();
    reachMax = false;
    page = 1;
    await getFreePosts();
  }

  doComment(int postId, int index) async {
    if (commentController.text.isEmpty) return;

    emit(DoCommentPatientLoading());
    var res = await _doCommentUseCase(
      title: 'title',
      content: commentController.text,
      postId: postId,
    );
    res.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(DoCommentPatientError(model: failure.errorModel!));
        } else if (failure is OfflineFailure) {
          emit(DoCommentPatientError(model: failure.model!));
        }
      },
      (r) {
        freePosts[index]
            .comments!
            .add(CommentModel(title: 'title', content: commentController.text));
        commentController.clear();
        emit(DoCommentPatientSuccess());
      },
    );
  }

  @override
  Future<void> close() {
    commentController.dispose();
    return super.close();
  }
}
