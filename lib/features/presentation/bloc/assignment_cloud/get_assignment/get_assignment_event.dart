part of 'get_assignment_bloc.dart';

abstract class GetAssignmentsEvent {}

class GetAssignmentsByClassEvent extends GetAssignmentsEvent {
  final String classCode;

  GetAssignmentsByClassEvent({
    required this.classCode,
  });
}
