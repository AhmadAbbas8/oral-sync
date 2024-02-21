import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/features/home_student_feature/domain/use_cases/create_post_use_case.dart';

part 'student_post_state.dart';

class StudentPostCubit extends Cubit<StudentPostState> {
  StudentPostCubit({
    required this.createPostUseCase,
  }) : super(StudentPostInitial());
  final CreatePostUseCase createPostUseCase;
  final picker = ServiceLocator.instance<ImagePicker>();
  final TextEditingController captionController = TextEditingController();
  List<XFile> pickedImages = [];
  List<File> pickedImagesFile = [];

  pickImages() async {
    pickedImages.clear();
    pickedImagesFile.clear();
    pickedImages = await picker.pickMultiImage();
    pickedImagesFile = pickedImages.map((e) => File(e.path)).toList();
    emit(PickImagesState(images: pickedImages));
  }

  createPost() async {
    emit(CreatePostLoading());
    var response = await createPostUseCase.call(
      content: captionController.text,
      images : pickedImagesFile,
    );
    response.fold((failure) {
      if (failure is ServerFailure) {
        emit(CreatePostError(responseModel: failure.errorModel));
      } else if (failure is OfflineFailure) {
        emit(CreatePostError(responseModel: failure.model));
      }
    }, (model) {
      emit(CreatePostSuccess(model: model));
    });
  }

  @override
  Future<void> close() {
    captionController.dispose();
    return super.close();
  }
}
