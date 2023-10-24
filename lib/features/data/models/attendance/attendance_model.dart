import 'package:final_project/features/domain/entities/attendance/attendance.dart';

class AttendanceModel {
  final String id;
  final String label;
  final String classCode;
  final String studentId;
  final String updatedAt;
  final String createdAt;

  const AttendanceModel(
      {required this.id,
      required this.label,
      required this.studentId,
      required this.updatedAt,
      required this.createdAt,
      required this.classCode});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        label: json["label"],
        classCode: json["class_code"],
        id: json["id"],
        studentId: json["student_id"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "class_code": classCode,
        "student_id": studentId,
        "updated_at": updatedAt,
        "created_at": createdAt,
      };

  Attendance toEntity() {
    return Attendance(
        id: id,
        label: label,
        studentId: studentId,
        updatedAt: updatedAt,
        createdAt: createdAt,
        classCode: classCode);
  }
}
