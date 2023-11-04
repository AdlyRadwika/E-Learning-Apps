part of 'get_grades_bloc.dart';

abstract class GetGradesEvent {}


class GetGradesByStudentEvent extends GetGradesEvent {
  final String classCode;
  final String studentId;

  GetGradesByStudentEvent({
    required this.classCode,
    required this.studentId,
  });
}
