part of 'get_attendance_bloc.dart';

abstract class GetAttendancesEvent {}


class GetAttendancesByClassEvent extends GetAttendancesEvent {
  final String classCode;

  GetAttendancesByClassEvent({
    required this.classCode,
  });
}
