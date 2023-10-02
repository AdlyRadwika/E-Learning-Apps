part of 'user_cloud_bloc.dart';

abstract class UserCloudState {}

class UserCloudInitial extends UserCloudState {}

class InsertUserLoading extends UserCloudState {}

class InsertUserResult extends UserCloudState {
  final String message;
  final bool isSuccess;

  InsertUserResult({this.message = '', required this.isSuccess});
}

class GetUserByIdLoading extends UserCloudState {}

class GetUserByIdResult extends UserCloudState {
  final String message;
  final bool isSuccess;
  final User? user;

  GetUserByIdResult({
    this.message = '',
    required this.isSuccess,
    this.user,
  });
}

class GetPhotoProfileURLLoading extends UserCloudState {}

class GetPhotoProfileURLResult extends UserCloudState {
  final String message;
  final bool isSuccess;
  final String url;

  GetPhotoProfileURLResult({
    this.message = '',
    required this.isSuccess,
    this.url = '',
  });
}
