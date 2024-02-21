import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/failure.dart';

import 'package:oralsync/features/home_student_feature/domain/repositories/student_post_repo.dart';

import '../../data/models/Student_post_model.dart';

class GetAllPostsStudentUseCase {
  final StudentPostRepo studentPostRepo;
  GetAllPostsStudentUseCase({required this.studentPostRepo});

  Future<Either<Failure, List<StudentPostModel>>> call() async =>
      await studentPostRepo.getAllPosts();
}
