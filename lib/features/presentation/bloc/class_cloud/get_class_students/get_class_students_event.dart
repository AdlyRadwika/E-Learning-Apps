part of 'get_class_students_bloc.dart';

abstract class GetClassStudentsEvent {}

class FetchStudentsEvent extends GetClassStudentsEvent {
  final String classCode;

  FetchStudentsEvent({
    required this.classCode,
  });
}