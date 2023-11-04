part of 'grade_cloud_bloc.dart';

abstract class GradeCloudState {}

class GradeCloudInitial extends GradeCloudState {}

class InsertGradeLoading extends GradeCloudState {}

class InsertGradeResult extends GradeCloudState {
  final String message;
  final bool isSuccess;

  InsertGradeResult({this.message = '', required this.isSuccess});
}

class UpdateGradeLoading extends GradeCloudState {}

class UpdateGradeResult extends GradeCloudState {
  final String message;
  final bool isSuccess;

  UpdateGradeResult({this.message = '', required this.isSuccess});
}