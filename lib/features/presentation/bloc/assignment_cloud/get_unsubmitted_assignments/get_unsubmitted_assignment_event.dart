part of 'get_unsubmitted_assignment_bloc.dart';

abstract class GetUnsubmittedAssignmentsEvent {}

class FetchUnsubmittedAssignmentEvent extends GetUnsubmittedAssignmentsEvent {
  final String assignmentId;

  FetchUnsubmittedAssignmentEvent({
    required this.assignmentId,
  });
}
