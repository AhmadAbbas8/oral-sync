part of 'student_post_cubit.dart';

abstract class StudentPostState extends Equatable {
  const StudentPostState();

  @override
  List<Object> get props => [];
}

class StudentPostInitial extends StudentPostState {}

class PickImagesState extends StudentPostState {
  final List<XFile> images;

  const PickImagesState({required this.images});

  @override
  // TODO: implement props
  List<Object> get props => [images];
}

class CreatePostLoading extends StudentPostState {}

class CreatePostSuccess extends StudentPostState {
  final ResponseModel model;

  const CreatePostSuccess({required this.model});
}

class CreatePostError extends StudentPostState {
  final ResponseModel? responseModel;

  const CreatePostError({this.responseModel});

}
