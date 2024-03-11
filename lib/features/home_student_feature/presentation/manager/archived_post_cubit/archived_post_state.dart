part of 'archived_post_cubit.dart';

abstract class ArchivedPostState extends Equatable {
  const ArchivedPostState();

  @override
  List<Object> get props => [];
}

class ArchivedPostInitial extends ArchivedPostState {}

class GetAllArchivedPostsLoading extends ArchivedPostState {}

class GetAllArchivedPostsError extends ArchivedPostState {
  final ResponseModel model;

  const GetAllArchivedPostsError({required this.model});

  @override
  List<Object> get props => [model];
}

class GetAllArchivedPostsSuccess extends ArchivedPostState {
  final List<StudentPostModel> posts;

  const GetAllArchivedPostsSuccess({required this.posts});

  @override
  List<Object> get props => [posts];
}
