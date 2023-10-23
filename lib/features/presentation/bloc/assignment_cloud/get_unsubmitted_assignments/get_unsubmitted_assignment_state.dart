part of 'get_unsubmitted_assignment_bloc.dart';

abstract class GetUnsubmittedAssignmentsState {}

class GetUnsubmittedAssignmentsInitial extends GetUnsubmittedAssignmentsState {}

class FetchUnsubmittedAssignmentLoading extends GetUnsubmittedAssignmentsState {}

class FetchUnsubmittedAssignmentResult extends GetUnsubmittedAssignmentsState {
  final String message;
  final bool isSuccess;
  final List<StudentsAssignmentStatus>? data;

  FetchUnsubmittedAssignmentResult({
    this.message = '',
    required this.isSuccess,
    this.data,
  });
}
