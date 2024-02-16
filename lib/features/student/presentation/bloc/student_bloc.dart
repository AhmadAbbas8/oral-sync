import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/features/student/presentation/pages/student_archived_screen.dart';
import 'package:oralsync/features/student/presentation/pages/student_home_screen.dart';
import 'package:oralsync/features/student/presentation/pages/student_message_screen.dart';
import 'package:oralsync/features/student/presentation/pages/student_profile_screen.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  int currentIndex = 0;
  List<Widget> theBody = [
    const StudentHomeScreen(),
    const StudentMessageScreen(),
    const StudentArchivedScreen(),
    const StudentProfileScreen(),
  ];
  StudentBloc() : super(StudentInitial()) {
    on<ChangeBottomNavigationBarIndexEvent>((event, emit) {
      currentIndex = event.index;
      emit(ChangeBottomNavigationBarIndexState());
    });
  }
}
