import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oralsync/core/helpers/extensions/navigation_extensions.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/archive_student_page.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/home_student_page.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/message_student_page.dart';
import 'package:oralsync/features/home_student_feature/presentation/pages/profile_student_page.dart';
import 'package:oralsync/translations/locale_keys.g.dart';

part 'student_home_state.dart';

class StudentHomeCubit extends Cubit<StudentHomeState> {
  StudentHomeCubit() : super(StudentHomeInitial());
  int currentNavIndex = 0;
  List<String> bottomNavTitle = const [
    LocaleKeys.home,
    LocaleKeys.messages,
    LocaleKeys.archived,
    LocaleKeys.profile,
  ];
  List<IconData> bottomNavIcons = const [
    IconBroken.Home,
    IconBroken.Message,
    Icons.archive_outlined,
    IconBroken.Profile,
  ];
  List<Widget> homePages =const [
    HomeStudentPage(),
    MessageStudentPage(),
    ArchiveStudentPage(),
    ProfileStudentPage(),
  ];

  navBarOnTap(int index,BuildContext context) {
    if(index == 3) {
      context.pushNamed(ProfileStudentPage.routeName);
      return ;
    }
    currentNavIndex = index;
    emit(ChangeNavBarIndex(index: index));
  }
}
