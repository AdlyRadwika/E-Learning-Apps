import 'package:final_project/features/data/models/attendance/attendance_model.dart';

class Attendance {
  final String id;
  final String label;
  final String classCode;
  final String studentId;
  final String updatedAt;
  final String createdAt;

  const Attendance(
      {required this.id,
      required this.label,
      required this.studentId,
      required this.updatedAt,
      required this.createdAt,
      required this.classCode});

  AttendanceModel toModel() {
    return AttendanceModel(
        id: id,
        label: label,
        studentId: studentId,
        updatedAt: updatedAt,
        createdAt: createdAt,
        classCode: classCode);
  }
}
