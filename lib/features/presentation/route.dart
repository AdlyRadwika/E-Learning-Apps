import 'package:final_project/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/presentation/pages/auth/login/login_page.dart';
import 'package:final_project/features/presentation/pages/auth/register/register_page.dart';
import 'package:final_project/features/presentation/pages/home/home_page.dart';
import 'package:final_project/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case HomePage.route:
      return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthBloc>(
                create: (context) => locator<AuthBloc>(),
                child: const HomePage(),
              ));
    case LoginPage.route:
      return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthBloc>(
                create: (context) => locator<AuthBloc>(),
                child: const LoginPage(),
              ));
    case RegisterPage.route:
      return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthBloc>(
                create: (context) => locator<AuthBloc>(),
                child: const RegisterPage(),
              ));
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('The page is not found'),
                ),
              ));
  }
}
