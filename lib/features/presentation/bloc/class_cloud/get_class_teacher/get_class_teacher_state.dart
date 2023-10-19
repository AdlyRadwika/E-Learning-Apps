part of 'get_class_teacher_bloc.dart';

abstract class GetClassTeacherState {}

class GetClassTeacherInitial extends GetClassTeacherState {}

class GetClassTeacherLoading extends GetClassTeacherState {}

class GetClassTeacherResult extends GetClassTeacherState {
  final String message;
  final bool isSuccess;
  final ClassUser? teacher;

  GetClassTeacherResult({
    this.message = '',
    required this.isSuccess,
    this.teacher,
  });
}