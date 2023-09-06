part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginResult extends AuthState {
  final String message;
  final bool isSuccess;

  LoginResult({this.message = '', required this.isSuccess});
}

class RegisterLoading extends AuthState {}

class RegisterResult extends AuthState {
  final String message;
  final bool isSuccess;

  RegisterResult({this.message = '', required this.isSuccess});
}

class LogoutResult extends AuthState {
  final String message;
  final bool isSuccess;

  LogoutResult({this.message = '', required this.isSuccess});
}
