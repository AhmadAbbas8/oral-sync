import 'package:flutter/material.dart';
import 'package:oralsync/core/shared_data_layer/actions_data_layer/model/ratings_model.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';
import 'package:oralsync/features/reservations_feature/data/models/reservation_model.dart';
import 'package:oralsync/features/settings_feature/presentation/pages/settings_screen.dart';
import 'package:oralsync/features/splash_feature/pages/splash_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:oralsync/features/home_patient_feature/data/models/DoctorModel.dart';

import '../../features/Auth/presentation/pages/login_page.dart';
import '../../features/Auth/presentation/pages/sign_up_doctor_page.dart';
import '../../features/Auth/presentation/pages/sign_up_options_page.dart';
import '../../features/Auth/presentation/pages/sign_up_patient_page.dart';
import '../../features/Auth/presentation/pages/sign_up_student_page.dart';
import '../../features/contact_us_feature/presentation/pages/contact_us_page.dart';
import '../../features/doctor_profile_feature/presentation/pages/doctor_profile_page.dart';
import '../../features/home_student_feature/presentation/pages/post_archived_details_page.dart';
import '../../features/profiles_view_from_patient/presentation/pages/doctor_profile_patient_view_page.dart';
import '../../features/doctor_profile_feature/presentation/pages/edit_profile_doctor_page.dart';
import '../../features/home_doctor_feature/presentation/pages/doctor_home_layout.dart';
import '../../features/home_feature/presentation/pages/home_page.dart';
import '../../features/messages_feature/presentation/pages/chat_page.dart';
import '../../features/home_patient_feature/presentation/pages/edit_profile_patient_page.dart';
import '../../features/home_patient_feature/presentation/pages/home_patient_layout.dart';
import '../../features/home_patient_feature/presentation/pages/patient_post_details_page.dart';
import '../../features/home_patient_feature/presentation/pages/profile_patient_page.dart';
import '../../features/profiles_view_from_patient/presentation/pages/student_profile_patient_view_page.dart';
import '../../features/rating_feature/presentation/pages/rating_page.dart';
import '../../features/reservations_feature/presentation/pages/add_rate_page.dart';
import '../shared_data_layer/actions_data_layer/model/Notification_model.dart';
import '../../features/home_student_feature/presentation/manager/student_edit_profile_cubit/student_edit_profile_cubit.dart';
import '../../features/home_student_feature/presentation/pages/create_post_page.dart';
import '../../features/home_student_feature/presentation/pages/edit_profile_page.dart';
import '../../features/home_student_feature/presentation/pages/home_student_page.dart';
import '../../features/home_student_feature/presentation/pages/notification_page.dart';
import '../../features/home_student_feature/presentation/pages/post_details_page.dart';
import '../../features/home_student_feature/presentation/pages/profile_student_page.dart';
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
      case SplashPage.routeName:
        return PageTransition(
          child: const SplashPage(),
          type: _generalType,
          curve: _generalCurve,
        );
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
      case HomeStudentLayoutPage.routeName:
        return PageTransition(
          child: const HomeStudentLayoutPage(),
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
      case SettingsScreen.routeName:
        return PageTransition(
          child:  SettingsScreen(userId: arguments as String),
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
      case PostArchivedDetailsPage.routeName:
        {
          var args = arguments as List;
          return PageTransition(
              child: PostArchivedDetailsPage(cubit: args[0], index: args[1]),
              type: _generalType);
        }
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
              child: PatientPostDetailsPage(
                  index: args[0], studentPostModel: args[1]),
              type: _generalType);
        }
      case ChatPage.routeName:
        {
          var args = settings.arguments as List;
          return PageTransition(
            child: ChatPage(
              index: args[0],
              imageUrl: args[1],
              userId: args[2],
              receiverId: args[3],
              isPatient: args[4],
              userName: args[5],
            ),
            type: _generalType,
          );
        }
      case HomeDoctorLayoutPage.routeName:
        return PageTransition(
            child: const HomeDoctorLayoutPage(), type: _generalType);
      case DoctorProfilePage.routeName:
        return PageTransition(
            child: const DoctorProfilePage(), type: _generalType);
      case EditProfileDoctorPage.routeName:
        return PageTransition(
            child: const EditProfileDoctorPage(), type: _generalType);
      case DoctorProfilePatientViewPage.routeName:
        return PageTransition(
          child: DoctorProfilePatientViewPage(
            doctorModel: settings.arguments as DoctorModel,
          ),
          type: _generalType,
        );

      case StudentProfilePatientViewPage.routeName:
        {
          List args = arguments as List;
          return PageTransition(
            child: StudentProfilePatientViewPage(
              user: args[0] as UserModel,
              userId: args[1] as String,
            ),
            type: _generalType,
          );
        }

      case RatingPage.routeName:
        return PageTransition(
          child: RatingPage(
            rates: arguments as List<RatingModel>,
          ),
          type: _generalType,
        );

      case AddRatePage.routeName:
        return PageTransition(
          child: AddRatePage(
            reservation: arguments as ReservationModel,
          ),
          type: _generalType,
        );

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
    HomeStudentLayoutPage.routeName: (context) => const HomeStudentLayoutPage(),
    HomeStudentPage.routeName: (context) => const HomeStudentPage(),
    ProfileStudentPage.routeName: (context) => const ProfileStudentPage(),
    CreatePostPage.routeName: (context) => const CreatePostPage(),
    // EditProfilePage.routeName: (context) => const EditProfilePage(),
    // SettingsScreen.routeName: (context) =>
    //     const SettingsScreen(),
    // NotificationPage.routeName: (context) =_> const NotificationPage(),
    // PostDetailsPage.routeName: (context) => const PostDetailsPage(),
  };
}
//comment
//second
