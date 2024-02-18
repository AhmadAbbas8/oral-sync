part of 'package:oralsync/features/home_student_feature/presentation/manager/student_bloc.dart';

abstract class StudentEvent {
  const StudentEvent();
}

class ChangeBottomNavigationBarIndexEvent extends StudentEvent {
  final int index;

  const ChangeBottomNavigationBarIndexEvent(this.index);
}
