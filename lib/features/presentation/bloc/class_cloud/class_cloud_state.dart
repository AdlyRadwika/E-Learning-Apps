part of 'class_cloud_bloc.dart';

abstract class ClassCloudState {}

class ClassCloudInitial extends ClassCloudState {}

class CreateClassLoading extends ClassCloudState {}

class CreateClassResult extends ClassCloudState {
  final String message;
  final bool isSuccess;

  CreateClassResult({this.message = '', required this.isSuccess});
}

class JoinClassLoading extends ClassCloudState {}

class JoinClassResult extends ClassCloudState {
  final String message;
  final bool isSuccess;

  JoinClassResult({this.message = '', required this.isSuccess});
}

class GetClassesByIdLoading extends ClassCloudState {}

class GetClassesByIdResult extends ClassCloudState {
  final String message;
  final bool isSuccess;
  final List<Class>? classes;

  GetClassesByIdResult({
    this.message = '',
    required this.isSuccess,
    this.classes,
  });
}

class GetEnrolledClassesByIdLoading extends ClassCloudState {}

class GetEnrolledClassesByIdResult extends ClassCloudState {
  final String message;
  final bool isSuccess;
  final List<EnrolledClass>? classes;

  GetEnrolledClassesByIdResult({
    this.message = '',
    required this.isSuccess,
    this.classes,
  });
}
