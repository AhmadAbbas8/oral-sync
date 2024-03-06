part of 'student_cubit.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object> get props => [];
}

class StudentInitial extends StudentState {}

class FetchNotificationLoading extends StudentState {}

class FetchNotificationError extends StudentState {
  final ResponseModel model;

  const FetchNotificationError({required this.model});

  @override
  List<Object> get props => [model];
}

class FetchNotificationSuccess extends StudentState {}

class ChangeNavBarIndex extends StudentState {
  final int index;

  const ChangeNavBarIndex({required this.index});

  @override
  List<Object> get props => [index];
}
