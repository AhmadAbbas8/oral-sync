part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class ChangeBottomNavigationBarIndexEvent extends StudentEvent {
  final int index;

  const ChangeBottomNavigationBarIndexEvent(this.index);
}
