part of 'get_other_user_bloc.dart';

abstract class GetOtherUserState {}

class GetOtherUserInitial extends GetOtherUserState {}

class GetOtherUserByIdLoading extends GetOtherUserState {}

class GetOtherUserByIdResult extends GetOtherUserState {
  final String message;
  final bool isSuccess;
  final User? user;

  GetOtherUserByIdResult({
    this.message = '',
    required this.isSuccess,
    this.user,
  });
}

