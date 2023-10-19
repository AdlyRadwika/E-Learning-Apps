part of 'get_announcements_bloc.dart';

abstract class GetAnnouncementsEvent {}


class GetAnnouncementsByClassEvent extends GetAnnouncementsEvent {
  final String classCode;

  GetAnnouncementsByClassEvent({
    required this.classCode,
  });
}
