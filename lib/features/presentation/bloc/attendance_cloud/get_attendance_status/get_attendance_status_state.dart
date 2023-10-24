part of 'get_attendance_status_bloc.dart';

abstract class GetAttendanceStatusState {}

class GetAttendanceStatusInitial extends GetAttendanceStatusState {}

class GetAttendanceStatusByStudentLoading extends GetAttendanceStatusState {}

class GetAttendanceStatusByStudentResult extends GetAttendanceStatusState {
  final String message;
  final bool isSuccess;
  final Stream<QuerySnapshot<AttendanceModel>>? statusStream;

  GetAttendanceStatusByStudentResult({
    this.message = '',
    required this.isSuccess,
    this.statusStream,
  });
}
