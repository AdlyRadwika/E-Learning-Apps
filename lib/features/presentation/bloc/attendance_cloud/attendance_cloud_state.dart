part of 'attendance_cloud_bloc.dart';

abstract class AttendanceCloudState {}

class AttendanceCloudInitial extends AttendanceCloudState {}

class InsertAttendanceLoading extends AttendanceCloudState {}

class InsertAttendanceResult extends AttendanceCloudState {
  final String message;
  final bool isSuccess;

  InsertAttendanceResult({this.message = '', required this.isSuccess});
}

