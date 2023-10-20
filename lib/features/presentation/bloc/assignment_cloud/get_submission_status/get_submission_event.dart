part of 'get_submission_bloc.dart';

abstract class GetSubmissionsEvent {}


class GetSubmissionsStatusEvent extends GetSubmissionsEvent {
  final String assignmentId;
  final String studentId;

  GetSubmissionsStatusEvent({
    required this.assignmentId,
    required this.studentId,
  });
}
