part of 'get_submitted_assignment_bloc.dart';

abstract class GetSubmittedAssignmentsEvent {}

class FetchSubmittedAssignmentEvent extends GetSubmittedAssignmentsEvent {
  final String assignmentId;

  FetchSubmittedAssignmentEvent({
    required this.assignmentId,
  });
}
