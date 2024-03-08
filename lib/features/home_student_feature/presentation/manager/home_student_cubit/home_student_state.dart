part of 'home_student_cubit.dart';

abstract class HomeStudentState extends Equatable {
  const HomeStudentState();

  @override
  List<Object> get props => [];
}

class HomeStudentInitial extends HomeStudentState {}
class ArchiveUnArchivePostLoading extends HomeStudentState {}
class ArchiveUnArchivePostError extends HomeStudentState {
  final ResponseModel model ;

  const ArchiveUnArchivePostError({required this.model});
  @override
  List<Object> get props => [model];
}
class ArchiveUnArchivePostSuccess extends HomeStudentState {
  final ResponseModel model;

  const ArchiveUnArchivePostSuccess({required this.model});
  @override
  // TODO: implement props
  List<Object> get props => [model];
}

class DoCommentLoading extends HomeStudentState {}
class DoCommentError extends HomeStudentState {
  final ResponseModel model;

  const DoCommentError({required this.model});
  @override
  List<Object> get props => [model];
}
class DoCommentSuccess extends HomeStudentState {}
class GetAllPostsLoading extends HomeStudentState {}

class GetAllPostsError extends HomeStudentState {
  final ResponseModel? responseModel;

  const GetAllPostsError({ this.responseModel});

  @override
  List<Object> get props => [responseModel??[]];
}

class GetAllPostsSuccess extends HomeStudentState {
  final List<StudentPostModel> posts;

  const GetAllPostsSuccess({required this.posts});

  @override
  List<Object> get props => [posts];
}
