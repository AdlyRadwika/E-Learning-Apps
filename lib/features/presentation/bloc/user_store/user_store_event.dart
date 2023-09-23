part of 'user_store_bloc.dart';

abstract class UserStoreEvent {}

class InsertUserEvent extends UserStoreEvent {
  final String uid;
  final String email;
  final String userName;
  final String role;

  InsertUserEvent(
      {required this.uid,
      required this.email,
      required this.userName,
      required this.role});
}
