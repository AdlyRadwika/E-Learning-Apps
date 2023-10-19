part of 'class_index_bloc.dart';

abstract class ClassIndexEvent {}

class GetClassesByIdEvent extends ClassIndexEvent {
  final String uid;

  GetClassesByIdEvent({
    required this.uid,
  });
}

class GetEnrolledClassesByIdEvent extends ClassIndexEvent {
  final String uid;

  GetEnrolledClassesByIdEvent({
    required this.uid,
  });
}