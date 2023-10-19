part of 'assignment_cloud_bloc.dart';

abstract class AssignmentCloudEvent {}

class InsertAssignmentEvent extends AssignmentCloudEvent {
  final Assignment data;

  InsertAssignmentEvent({
    required this.data,
  });
}

class UpdateAssignmentEvent extends AssignmentCloudEvent {
  final Assignment data;

  UpdateAssignmentEvent({
    required this.data,
  });
}

class DeleteAssignmentEvent extends AssignmentCloudEvent {
  final String id;

  DeleteAssignmentEvent({
    required this.id,
  });
}
