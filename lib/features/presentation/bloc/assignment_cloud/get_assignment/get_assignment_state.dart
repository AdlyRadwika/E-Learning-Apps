part of 'get_assignment_bloc.dart';

abstract class GetAssignmentsState {}

class GetAssignmentsInitial extends GetAssignmentsState {}

class GetAssignmentsByClassLoading extends GetAssignmentsState {}

class GetAssignmentsByClassResult extends GetAssignmentsState {
  final String message;
  final bool isSuccess;
  final Stream<QuerySnapshot<AssignmentModel>>? assignmentStream;

  GetAssignmentsByClassResult({
    this.message = '',
    required this.isSuccess,
    this.assignmentStream,
  });
}
