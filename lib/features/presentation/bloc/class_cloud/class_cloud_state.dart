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