part of 'user_store_bloc.dart';

abstract class UserStoreState {}

class UserStoreInitial extends UserStoreState {}

class InsertUserLoading extends UserStoreState {}

class InsertUserResult extends UserStoreState {
  final String message;
  final bool isSuccess;

  InsertUserResult({this.message = '', required this.isSuccess});
}
