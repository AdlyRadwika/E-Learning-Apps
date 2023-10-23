part of 'get_submitted_assignment_bloc.dart';

abstract class GetSubmittedAssignmentsState {}

class GetSubmittedAssignmentsInitial extends GetSubmittedAssignmentsState {}

class FetchSubmittedAssignmentLoading extends GetSubmittedAssignmentsState {}

class FetchSubmittedAssignmentResult extends GetSubmittedAssignmentsState {
  final String message;
  final bool isSuccess;
  final List<StudentsAssignmentStatus>? data;

  FetchSubmittedAssignmentResult({
    this.message = '',
    required this.isSuccess,
    this.data,
  });
}
