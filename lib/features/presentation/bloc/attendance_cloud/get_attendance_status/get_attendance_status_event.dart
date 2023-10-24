part of 'get_attendance_status_bloc.dart';

abstract class GetAttendanceStatusEvent {}


class GetAttendanceStatusByStudentEvent extends GetAttendanceStatusEvent {
  final String classCode;
  final String studentId;

  GetAttendanceStatusByStudentEvent({
    required this.classCode,
    required this.studentId,
  });
}
