part of 'user_cloud_bloc.dart';

abstract class UserCloudEvent {}

class InsertUserEvent extends UserCloudEvent {
  final String uid;
  final String email;
  final String userName;
  final String role;
  final List imageData;
  final String imageUrl;

  InsertUserEvent({
    required this.uid,
    required this.email,
    required this.userName,
    required this.role,
    required this.imageData,
    this.imageUrl = '',
  });
}

class GetUserByIdEvent extends UserCloudEvent {
  final String uid;

  GetUserByIdEvent({
    required this.uid,
  });
}
