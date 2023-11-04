import 'package:final_project/features/data/models/grade/grade_model.dart';

class Grade {
  final String id;
  final String assignmentId;
  final String classCode;
  final int grade;
  final String studentId;
  final String updatedAt;
  final String createdAt;

  const Grade(
      {required this.id,
      required this.grade,
      required this.classCode,
      required this.studentId,
      required this.updatedAt,
      required this.createdAt,
      required this.assignmentId});

  GradeModel toModel() {
    return GradeModel(
        id: id,
        grade: grade,
        classCode: classCode,
        studentId: studentId,
        updatedAt: updatedAt,
        createdAt: createdAt,
        assignmentId: assignmentId);
  }
}
