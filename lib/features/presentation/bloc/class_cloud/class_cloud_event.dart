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

class GetClassesByIdEvent extends ClassCloudEvent {
  final String uid;

  GetClassesByIdEvent({
    required this.uid,
  });
}
