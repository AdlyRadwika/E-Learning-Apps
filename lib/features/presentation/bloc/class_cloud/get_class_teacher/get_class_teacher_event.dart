part of 'get_class_teacher_bloc.dart';

abstract class GetClassTeacherEvent {}

class FetchTeacherEvent extends GetClassTeacherEvent {
  final String classCode;

  FetchTeacherEvent({
    required this.classCode,
  });
}