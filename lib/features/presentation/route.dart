import 'package:final_project/features/presentation/pages/auth/login/login_page.dart';
import 'package:final_project/features/presentation/pages/auth/register/register_page.dart';
import 'package:final_project/features/presentation/pages/face_recognition/face_registered_page.dart';
import 'package:final_project/features/presentation/pages/face_recognition/index_page.dart';
import 'package:final_project/features/presentation/pages/face_recognition/face_recognitionv2_page.dart';
import 'package:final_project/features/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case HomePage.route:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case LoginPage.route:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case RegisterPage.route:
      return MaterialPageRoute(builder: (context) => const RegisterPage());
    case IndexPage.route:
      return MaterialPageRoute(builder: (context) => const IndexPage());
    case FaceDetectionPage.route:
      return MaterialPageRoute(builder: (context) => const FaceDetectionPage());
    case FaceRecognitionV2Page.route:
      return MaterialPageRoute(
          builder: (context) => const FaceRecognitionV2Page());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('The page is not found'),
                ),
              ));
  }
}
