part of 'class_cloud_bloc.dart';

abstract class ClassCloudState {}

class ClassCloudInitial extends ClassCloudState {}

class CreateClassLoading extends ClassCloudState {}

class CreateClassResult extends ClassCloudState {
  final String message;
  final bool isSuccess;

  CreateClassResult({this.message = '', required this.isSuccess});
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
