part of 'student_edit_profile_cubit.dart';

abstract class StudentEditProfileState extends Equatable {
  const StudentEditProfileState();

  @override
  List<Object> get props => [];
}

class StudentEditProfileInitial extends StudentEditProfileState {}

class DateChangedState extends StudentEditProfileState {}

class ChangeGender extends StudentEditProfileState {
  final bool isMale;

  const ChangeGender({required this.isMale});

  @override
  // TODO: implement props
  List<Object> get props => [isMale];
}

class UpdateStudentDataLoading extends StudentEditProfileState {}

class UpdateStudentDataError extends StudentEditProfileState {
  final ResponseModel responseModel;

  const UpdateStudentDataError({required this.responseModel});

  @override
  List<Object> get props => [responseModel];
}

class UpdateStudentDataSuccess extends StudentEditProfileState {}

class ChangeProfileLoading extends StudentEditProfileState {}

class ChangeProfileSuccess extends StudentEditProfileState {
  final String image;

  const ChangeProfileSuccess({required this.image});

  @override
  List<Object> get props => [image];
}

class ChangeProfileError extends StudentEditProfileState {
  final ResponseModel responseModel;

  const ChangeProfileError({required this.responseModel});

  @override
  List<Object> get props => [responseModel];
}
