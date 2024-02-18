part of 'student_home_cubit.dart';

abstract class StudentHomeState extends Equatable {
  const StudentHomeState();

  @override
  List<Object> get props => [];
}

class StudentHomeInitial extends StudentHomeState {}

class ChangeNavBarIndex extends StudentHomeState {
  final int index;

  const ChangeNavBarIndex({required this.index});

  @override
  List<Object> get props => [index];
}
