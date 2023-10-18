part of 'class_cloud_bloc.dart';

abstract class ClassCloudEvent {}

class CreateClassEvent extends ClassCloudEvent {
  final String code;
  final String title;
  final String description;
  final String teacherId;

  CreateClassEvent({
    required this.code,
    required this.title,
    required this.description,
    required this.teacherId,
  });
}

class JoinClassEvent extends ClassCloudEvent {
  final String code;
  final String uid;

  JoinClassEvent({
    required this.code,
    required this.uid,
  });
}

class GetClassesByIdEvent extends ClassCloudEvent {
  final String uid;

  GetClassesByIdEvent({
    required this.uid,
  });
}

class GetEnrolledClassesByIdEvent extends ClassCloudEvent {
  final String uid;

  GetEnrolledClassesByIdEvent({
    required this.uid,
  });
}
