import 'package:final_project/features/domain/entities/Grade/Grade.dart';

class GradeModel {
  final String id;
  final String assignmentId;
  final int grade;
  final String classCode;
  final String studentId;
  final String updatedAt;
  final String createdAt;

  const GradeModel(
      {required this.id,
      required this.grade,
      required this.classCode,
      required this.studentId,
      required this.updatedAt,
      required this.createdAt,
      required this.assignmentId});

  factory GradeModel.fromJson(Map<String, dynamic> json) =>
      GradeModel(
        assignmentId: json["assignment_id"],
        id: json["id"],
        classCode: json["class_code"],
        grade: json["grade"],
        studentId: json["student_id"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "assignment_id": assignmentId,
        "grade": grade,
        "class_code": classCode,
        "student_id": studentId,
        "updated_at": updatedAt,
        "created_at": createdAt,
      };

  Grade toEntity() {
    return Grade(
        id: id,
        grade: grade,
        classCode: classCode,
        studentId: studentId,
        updatedAt: updatedAt,
        createdAt: createdAt,
        assignmentId: assignmentId);
  }
}
