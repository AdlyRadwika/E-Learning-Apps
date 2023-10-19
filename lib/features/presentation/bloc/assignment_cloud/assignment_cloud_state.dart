part of 'assignment_cloud_bloc.dart';

abstract class AssignmentCloudState {}

class AssignmentCloudInitial extends AssignmentCloudState {}

class InsertAssignmentLoading extends AssignmentCloudState {}

class InsertAssignmentResult extends AssignmentCloudState {
  final String message;
  final bool isSuccess;

  InsertAssignmentResult({this.message = '', required this.isSuccess});
}

class UpdateAssignmentLoading extends AssignmentCloudState {}

class UpdateAssignmentResult extends AssignmentCloudState {
  final String message;
  final bool isSuccess;

  UpdateAssignmentResult({this.message = '', required this.isSuccess});
}

class DeleteAssignmentLoading extends AssignmentCloudState {}

class DeleteAssignmentResult extends AssignmentCloudState {
  final String message;
  final bool isSuccess;

  DeleteAssignmentResult({this.message = '', required this.isSuccess});
}
