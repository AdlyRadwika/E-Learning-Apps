part of 'get_assignment_schedule_bloc.dart';

abstract class GetScheduleState {}

class GetScheduleInitial extends GetScheduleState {}

class GetScheduleLoading extends GetScheduleState {}

class GetAssignmentsSchedulesResult extends GetScheduleState {
  final String message;
  final bool isSuccess;
  final List<Assignment>? assignments;

  GetAssignmentsSchedulesResult({
    this.message = '',
    required this.isSuccess,
    this.assignments,
  });
}

class GetTeacherScheduleResult extends GetScheduleState {
  final String message;
  final bool isSuccess;
  final List<Assignment>? assignments;

  GetTeacherScheduleResult({
    this.message = '',
    required this.isSuccess,
    this.assignments,
  });
}
