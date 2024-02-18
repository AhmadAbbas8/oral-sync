import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'student_home_state.dart';

class StudentHomeCubit extends Cubit<StudentHomeState> {
  StudentHomeCubit() : super(StudentHomeInitial());
  int currentNavIndex = 0;
}
