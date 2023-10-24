import 'package:final_project/features/domain/entities/attendance/attendance_content.dart';

class AttendanceContentModel {
  final String id;
  final String label;
  final String studentId;
  final String studentName;
  final String studentImageUrl;
  final String attendanceDate;

  const AttendanceContentModel({
    required this.id,
    required this.label,
    required this.studentId,
    required this.studentImageUrl,
    required this.studentName,
    required this.attendanceDate,
  });

  AttendanceContent toEntity() {
    return AttendanceContent(
        id: id,
        label: label,
        studentId: studentId,
        studentImageUrl: studentImageUrl,
        studentName: studentName,
        attendanceDate: attendanceDate);
  }
}
