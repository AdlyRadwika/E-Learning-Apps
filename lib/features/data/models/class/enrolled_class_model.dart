import 'package:final_project/features/domain/entities/class/enrolled_class.dart';

class EnrolledClassModel {
  final String code;
  final String title;
  final String description;
  final String studentId;
  final String updatedAt;
  final String createdAt;

  const EnrolledClassModel(
      {required this.title,
      required this.description,
      required this.studentId,
      required this.updatedAt,
      required this.createdAt,
      required this.code});

  factory EnrolledClassModel.fromJson(Map<String, dynamic> json) =>
      EnrolledClassModel(
        code: json["code"],
        title: json["title"],
        description: json["description"],
        studentId: json["student_id"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "title": title,
        "description": description,
        "student_id": studentId,
        "updated_at": updatedAt,
        "created_at": createdAt,
      };

  EnrolledClass toEntity() {
    return EnrolledClass(
        title: title,
        description: description,
        studentId: studentId,
        updatedAt: updatedAt,
        createdAt: createdAt,
        code: code);
  }
}
