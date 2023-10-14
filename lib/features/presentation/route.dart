import 'package:final_project/features/presentation/pages/auth/login/login_page.dart';
import 'package:final_project/features/presentation/pages/auth/register/register_page.dart';
import 'package:final_project/features/presentation/pages/auth/reset_password/reset_password_page.dart';
import 'package:final_project/features/presentation/pages/auth/update_password/update_password_page.dart';
import 'package:final_project/features/presentation/pages/class/action_result/action_result_page.dart';
import 'package:final_project/features/presentation/pages/class/announcements/announcements_page.dart';
import 'package:final_project/features/presentation/pages/class/assignment_detail/assignment_detail_page.dart';
import 'package:final_project/features/presentation/pages/class/assignments/assignments_page.dart';
import 'package:final_project/features/presentation/pages/class/attendance/attendance_page.dart';
import 'package:final_project/features/presentation/pages/class/detail/class_detail.dart';
import 'package:final_project/features/presentation/pages/class/index/class_index_page.dart';
import 'package:final_project/features/presentation/pages/class/info/class_info_page.dart';
import 'package:final_project/features/presentation/pages/face_recognition/face_recognitionv2_page.dart';
import 'package:final_project/features/presentation/pages/home/home_page.dart';
import 'package:final_project/features/presentation/pages/profile/profile_page.dart';
import 'package:final_project/features/presentation/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

Route<dynamic>? controller(RouteSettings settings) {
  switch (settings.name) {
    case SplashPage.route:
      return MaterialPageRoute(builder: (context) => const SplashPage());
    case HomePage.route:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case LoginPage.route:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case RegisterPage.route:
      return MaterialPageRoute(builder: (context) => const RegisterPage());
    case ResetPasswordPage.route:
      return MaterialPageRoute(builder: (context) => const ResetPasswordPage());
    case FaceRecognitionV2Page.route:
      final Map<String, dynamic> args =
          settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (context) => FaceRecognitionV2Page(
                isAttendance: args["isAttendance"] ?? false,
                isUpdate: args["isUpdate"] ?? false,
              ));
    case ProfilePage.route:
      return MaterialPageRoute(builder: (context) => const ProfilePage());
    case UpdatePasswordPage.route:
      return MaterialPageRoute(
          builder: (context) => const UpdatePasswordPage());
    case ClassIndexPage.route:
      return MaterialPageRoute(builder: (context) => const ClassIndexPage());
    case ActionResultPage.route:
      return MaterialPageRoute(builder: (context) => const ActionResultPage());
    case ClassDetailPage.route:
      return MaterialPageRoute(builder: (context) => const ClassDetailPage());
    case AttendancePage.route:
      return MaterialPageRoute(builder: (context) => const AttendancePage());
    case ClassInfoPage.route:
      return MaterialPageRoute(builder: (context) => const ClassInfoPage());
    case AnnouncementsPage.route:
      return MaterialPageRoute(builder: (context) => const AnnouncementsPage());
    case AssignmentsPage.route:
      return MaterialPageRoute(builder: (context) => const AssignmentsPage());
    case AssignmentDetailPage.route:
      return MaterialPageRoute(
          builder: (context) => const AssignmentDetailPage());
    default:
      return null;
  }
}
