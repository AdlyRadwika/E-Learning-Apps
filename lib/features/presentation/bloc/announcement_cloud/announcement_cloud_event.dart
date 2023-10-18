part of 'announcement_cloud_bloc.dart';

abstract class AnnouncementCloudEvent {}

class InsertAnnouncementEvent extends AnnouncementCloudEvent {
  final String announcementId;
  final String teacherId;
  final String content;
  final String classCode;

  InsertAnnouncementEvent({
    required this.announcementId,
    required this.teacherId,
    required this.content,
    required this.classCode,
  });
}

class GetAnnouncementsByUidEvent extends AnnouncementCloudEvent {
  final String uid;

  GetAnnouncementsByUidEvent({
    required this.uid,
  });
}

class UpdateAnnouncementEvent extends AnnouncementCloudEvent {
  final String id;
  final String content;

  UpdateAnnouncementEvent({
    required this.id,
    required this.content,
  });
}

class DeleteAnnouncementEvent extends AnnouncementCloudEvent {
  final String id;

  DeleteAnnouncementEvent({
    required this.id,
  });
}
