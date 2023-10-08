import 'package:final_project/features/presentation/pages/auth/login/login_page.dart';
import 'package:final_project/features/presentation/pages/auth/register/register_page.dart';
import 'package:final_project/features/presentation/pages/auth/reset_password/reset_password_page.dart';
import 'package:final_project/features/presentation/pages/auth/update_password/update_password_page.dart';
import 'package:final_project/features/presentation/pages/class/index/class_index_page.dart';
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
      return MaterialPageRoute(builder: (context) => const UpdatePasswordPage());
    case ClassIndexPage.route:
      return MaterialPageRoute(builder: (context) => const ClassIndexPage());
    default:
      return null;
  }
}
