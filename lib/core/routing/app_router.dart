import 'package:flutter/material.dart';
import 'package:oralsync/features/home_patient_feature/presentation/pages/home_patient_layout.dart';
import 'package:oralsync/features/contact_us_feature/presentation/pages/contact_us_page.dart';
import 'package:page_transition/page_transition.dart';

import '../../features/Auth/presentation/pages/login_page.dart';
import '../../features/Auth/presentation/pages/sign_up_doctor_page.dart';
import '../../features/Auth/presentation/pages/sign_up_options_page.dart';
import '../../features/Auth/presentation/pages/sign_up_patient_page.dart';
import '../../features/Auth/presentation/pages/sign_up_student_page.dart';
import '../../features/home_feature/presentation/pages/home_page.dart';
import '../../features/home_patient_feature/presentation/pages/chat_page.dart';
import '../../features/home_patient_feature/presentation/pages/edit_profile_patient_page.dart';
import '../../features/home_patient_feature/presentation/pages/patient_post_details_page.dart';
import '../../features/home_patient_feature/presentation/pages/profile_patient_page.dart';
import '../shared_data_layer/actions_data_layer/model/Notification_model.dart';
import '../../features/home_student_feature/presentation/manager/student_edit_profile_cubit/student_edit_profile_cubit.dart';
import '../../features/home_student_feature/presentation/pages/create_post_page.dart';
import '../../features/home_student_feature/presentation/pages/edit_profile_page.dart';
import '../../features/home_student_feature/presentation/pages/home_student_page.dart';
import '../../features/home_student_feature/presentation/pages/notification_page.dart';
import '../../features/home_student_feature/presentation/pages/post_details_page.dart';
import '../../features/home_student_feature/presentation/pages/profile_student_page.dart';
import '../../features/home_student_feature/presentation/pages/settings_of_student_screen.dart';
import '../../features/home_student_feature/presentation/pages/student_home_layout_page.dart';

class AppRouter {
  AppRouter._();

  static final navigatorKey = GlobalKey<NavigatorState>();
  static const PageTransitionType _generalType = PageTransitionType.fade;
  static const Curve _generalCurve = Curves.bounceInOut;

  static Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;
    switch (settings.name) {
      case LoginPage.routeName:
        return PageTransition(
          child: const LoginPage(),
          type: _generalType,
          curve: _generalCurve,
        );
      case SignUpOptionsPage.routeName:
        return PageTransition(
          child: const SignUpOptionsPage(),
          type: _generalType,
          curve: _generalCurve,
        );
      case SignUpPatientPage.routeName:
        return PageTransition(
          child: const SignUpPatientPage(),
          type: _generalType,
          curve: _generalCurve,
        );
      case SignUpDoctorPage.routeName:
        return PageTransition(
          child: const SignUpDoctorPage(),
          type: _generalType,
          curve: _generalCurve,
        );
      case SignUpStudentPage.routeName:
        return PageTransition(
          child: const SignUpStudentPage(),
          type: _generalType,
          curve: _generalCurve,
        );
      case HomePage.routeName:
        return PageTransition(
          child: const HomePage(),
          type: _generalType,
          curve: _generalCurve,
        );
      case StudentHomeLayoutPage.routeName:
        return PageTransition(
          child: const StudentHomeLayoutPage(),
          type: _generalType,
          curve: _generalCurve,
        );
      case HomeStudentPage.routeName:
        return PageTransition(
          child: const HomeStudentPage(),
          type: _generalType,
          curve: _generalCurve,
        );
      case ProfileStudentPage.routeName:
        return PageTransition(
          child: const ProfileStudentPage(),
          type: _generalType,
          curve: _generalCurve,
        );
      case CreatePostPage.routeName:
        return PageTransition(
          child: const CreatePostPage(),
          type: _generalType,
          curve: _generalCurve,
        );
      case EditProfileStudentPage.routeName:
        return PageTransition(
          child: EditProfileStudentPage(
            passedCubit: settings.arguments as StudentEditProfileCubit,
          ),
          type: _generalType,
          curve: _generalCurve,
        );
      case SettingsOfStudentScreen.routeName:
        return PageTransition(
          child: const SettingsOfStudentScreen(),
          type: _generalType,
          curve: _generalCurve,
        );
      case NotificationPage.routeName:
        return PageTransition(
          child: NotificationPage(
            notifications: arguments as List<NotificationModel>,
          ),
          type: _generalType,
          curve: _generalCurve,
        );
      case PostDetailsPage.routeName:
        {
          var args = settings.arguments as List;
          return PageTransition(
            child: PostDetailsPage(
              cubit: args[0],
              index: args[1],
            ),
            type: _generalType,
            curve: _generalCurve,
          );
        }
      case ContactUsPage.routeName:
        return PageTransition(child: const ContactUsPage(), type: _generalType);
      case HomePatientLayoutPage.routeName:
        return PageTransition(
            child: const HomePatientLayoutPage(), type: _generalType);
      case ProfilePatientPage.routeName:
        return PageTransition(
            child: const ProfilePatientPage(), type: _generalType);
      case EditProfilePatientPage.routeName:
        return PageTransition(
            child: const EditProfilePatientPage(), type: _generalType);
      case PatientPostDetailsPage.routeName:
        {
          var args = settings.arguments as List;
          return PageTransition(
              child: PatientPostDetailsPage(index: args[0]),
              type: _generalType);
        }
      case ChatPage.routeName:
        {
          var args  = settings.arguments as int;
          return PageTransition(child: ChatPage(index: args), type: _generalType);
        }

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Invalid Route Name ${settings.name}'),
            ),
          ),
        );
    }
  }

  static final routes = {
    LoginPage.routeName: (context) => const LoginPage(),
    SignUpOptionsPage.routeName: (context) => const SignUpOptionsPage(),
    SignUpPatientPage.routeName: (context) => const SignUpPatientPage(),
    SignUpDoctorPage.routeName: (context) => const SignUpDoctorPage(),
    SignUpStudentPage.routeName: (context) => const SignUpStudentPage(),
    HomePage.routeName: (context) => const HomePage(),
    StudentHomeLayoutPage.routeName: (context) => const StudentHomeLayoutPage(),
    HomeStudentPage.routeName: (context) => const HomeStudentPage(),
    ProfileStudentPage.routeName: (context) => const ProfileStudentPage(),
    CreatePostPage.routeName: (context) => const CreatePostPage(),
    // EditProfilePage.routeName: (context) => const EditProfilePage(),
    SettingsOfStudentScreen.routeName: (context) =>
        const SettingsOfStudentScreen(),
    // NotificationPage.routeName: (context) =_> const NotificationPage(),
    // PostDetailsPage.routeName: (context) => const PostDetailsPage(),
  };
}
