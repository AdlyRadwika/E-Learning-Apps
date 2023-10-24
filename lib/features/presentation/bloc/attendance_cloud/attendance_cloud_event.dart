part of 'attendance_cloud_bloc.dart';

abstract class AttendanceCloudEvent {}

class InsertAttendanceEvent extends AttendanceCloudEvent {
  final Attendance data;

  InsertAttendanceEvent({
    required this.data,
  });
}