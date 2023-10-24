import 'package:final_project/features/presentation/pages/auth/login/login_page.dart';
import 'package:final_project/features/presentation/pages/auth/register/register_page.dart';
import 'package:final_project/features/presentation/pages/auth/reset_password/reset_password_page.dart';
import 'package:final_project/features/presentation/pages/auth/update_password/update_password_page.dart';
import 'package:final_project/features/presentation/pages/class/action_result/action_result_page.dart';
import 'package:final_project/features/presentation/pages/class/announcements/announcements_page.dart';
import 'package:final_project/features/presentation/pages/class/announcements/post_announcement_page.dart';
import 'package:final_project/features/presentation/pages/class/assignment_detail/assignment_detail_page.dart';
import 'package:final_project/features/presentation/pages/class/assignments/add_assignment_page.dart';
import 'package:final_project/features/presentation/pages/class/assignments/assignments_page.dart';
import 'package:final_project/features/presentation/pages/class/attendance/attendance_page.dart';
import 'package:final_project/features/presentation/pages/class/detail/class_detail.dart';
import 'package:final_project/features/presentation/pages/class/detail/enrolled_class_detail.dart';
import 'package:final_project/features/presentation/pages/class/index/class_index_page.dart';
import 'package:final_project/features/presentation/pages/class/info/class_info_page.dart';
import 'package:final_project/features/presentation/pages/class/info/enrolled_class_info_page.dart';
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
                classCode: args['classCode'] ?? '-',
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
      Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (context) => ClassDetailPage(
                data: args['data'],
              ));
    case EnrolledClassDetailPage.route:
      Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (context) => EnrolledClassDetailPage(
                data: args['data'],
              ));
    case AttendancePage.route:
    Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(builder: (context) => AttendancePage(
        classTitle: args['classTitle'] ?? '-',
        classCode: args['classCode'] ?? '-',
      ));
    case ClassInfoPage.route:
      Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (context) => ClassInfoPage(
                data: args['data'],
              ));
    case EnrolledClassInfoPage.route:
      Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (context) => EnrolledClassInfoPage(
                data: args['data'],
              ));
    case AnnouncementsPage.route:
      Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (context) => AnnouncementsPage(
                classCode: args['classCode'],
              ));
    case AssignmentsPage.route:
      Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (context) => AssignmentsPage(
                classCode: args['classCode'],
              ));
    case AssignmentDetailPage.route:
      Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (context) => AssignmentDetailPage(
                data: args['data'],
              ));
    case PostAnnouncementPage.route:
      Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (context) => PostAnnouncementPage(
                isUpdate: args['isUpdate'],
                announcementId: args['announcementId'],
                contentText: args['contentText'],
                classCode: args['classCode'],
              ));
    case AddAssignmentPage.route:
      Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (context) => AddAssignmentPage(
                classCode: args['classCode'],
                data: args['data'],
                isEdit: args['isEdit'],
              ));
    default:
      return null;
  }
}
