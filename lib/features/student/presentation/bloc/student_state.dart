part of 'student_bloc.dart';

abstract class StudentState extends Equatable {
  const StudentState();  

  @override
  List<Object> get props => [];
}
class StudentInitial extends StudentState {}
