part of 'get_attendance_bloc.dart';

abstract class GetAttendancesState {}

class GetAttendancesInitial extends GetAttendancesState {}

class GetAttendancesByClassLoading extends GetAttendancesState {}

class GetAttendancesByClassResult extends GetAttendancesState {
  final String message;
  final bool isSuccess;
  final List<AttendanceContent>? attendances;

  GetAttendancesByClassResult({
    this.message = '',
    required this.isSuccess,
    this.attendances,
  });
}
