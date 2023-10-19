part of 'get_class_students_bloc.dart';

abstract class GetClassStudentsState {}

class GetClassStudentsInitial extends GetClassStudentsState {}

class GetClassStudentsLoading extends GetClassStudentsState {}

class GetClassStudentsResult extends GetClassStudentsState {
  final String message;
  final bool isSuccess;
  final List<ClassUser>? students;

  GetClassStudentsResult({
    this.message = '',
    required this.isSuccess,
    this.students,
  });
}