part of 'announcement_cloud_bloc.dart';

abstract class AnnouncementCloudState {}

class AnnouncementCloudInitial extends AnnouncementCloudState {}

class InsertAnnouncementLoading extends AnnouncementCloudState {}

class InsertAnnouncementResult extends AnnouncementCloudState {
  final String message;
  final bool isSuccess;

  InsertAnnouncementResult({this.message = '', required this.isSuccess});
}

class UpdateAnnouncementLoading extends AnnouncementCloudState {}

class UpdateAnnouncementResult extends AnnouncementCloudState {
  final String message;
  final bool isSuccess;

  UpdateAnnouncementResult({this.message = '', required this.isSuccess});
}

class DeleteAnnouncementLoading extends AnnouncementCloudState {}

class DeleteAnnouncementResult extends AnnouncementCloudState {
  final String message;
  final bool isSuccess;

  DeleteAnnouncementResult({this.message = '', required this.isSuccess});
}

class GetAnnouncementsByUidLoading extends AnnouncementCloudState {}

class GetAnnouncementsByUidResult extends AnnouncementCloudState {
  final String message;
  final bool isSuccess;
  final List<Announcement>? announcements;

  GetAnnouncementsByUidResult({
    this.message = '',
    required this.isSuccess,
    this.announcements,
  });
}
