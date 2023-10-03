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
  final User? user;

  RegisterResult({this.message = '', required this.isSuccess, this.user});
}

class LogoutResult extends AuthState {
  final String message;
  final bool isSuccess;

  LogoutResult({this.message = '', required this.isSuccess});
}

class ResetPasswordLoading extends AuthState {}

class ResetPasswordResult extends AuthState {
  final String message;
  final bool isSuccess;

  ResetPasswordResult({this.message = '', required this.isSuccess});
}

class UpdatePasswordLoading extends AuthState {}

class UpdatePasswordResult extends AuthState {
  final String message;
  final bool isSuccess;

  UpdatePasswordResult({this.message = '', required this.isSuccess});
}
