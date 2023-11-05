part of 'get_assignment_schedule_bloc.dart';

abstract class GetScheduleEvent {}

class GetAssignmentsSchedulesEvent extends GetScheduleEvent {
  final String studentId;

  GetAssignmentsSchedulesEvent({
    required this.studentId,
  });
}

class GetTeacherScheduleEvent extends GetScheduleEvent {
  final String teacherId;

  GetTeacherScheduleEvent({
    required this.teacherId,
  });
}
