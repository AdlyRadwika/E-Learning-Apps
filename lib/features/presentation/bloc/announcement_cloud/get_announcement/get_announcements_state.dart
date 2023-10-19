part of 'get_announcements_bloc.dart';

abstract class GetAnnouncementsState {}

class GetAnnouncementsInitial extends GetAnnouncementsState {}

class GetAnnouncementsByClassLoading extends GetAnnouncementsState {}

class GetAnnouncementsByClassResult extends GetAnnouncementsState {
  final String message;
  final bool isSuccess;
  final List<AnnouncementContent>? announcements;

  GetAnnouncementsByClassResult({
    this.message = '',
    required this.isSuccess,
    this.announcements,
  });
}
