part of 'get_other_user_bloc.dart';

abstract class GetOtherUserEvent {}


class GetOtherUserByIdEvent extends GetOtherUserEvent {
  final String uid;

  GetOtherUserByIdEvent({
    required this.uid,
  });
}