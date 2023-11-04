part of 'get_grades_bloc.dart';

abstract class GetGradesState {}

class GetGradesInitial extends GetGradesState {}

class GetGradesByStudentLoading extends GetGradesState {}

class GetGradesByStudentResult extends GetGradesState {
  final String message;
  final bool isSuccess;
  final GradeContent? grade;

  GetGradesByStudentResult({
    this.message = '',
    required this.isSuccess,
    this.grade,
  });
}
