import 'package:final_project/features/domain/entities/class/class.dart';

class ClassModel {
  final String code;
  final String title;
  final String description;
  final String teacherId;
  final String updatedAt;
  final String createdAt;

  const ClassModel(
      {required this.title,
      required this.description,
      required this.teacherId,
      required this.updatedAt,
      required this.createdAt,
      required this.code});

  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
        code: json["code"],
        title: json["title"],
        description: json["description"],
        teacherId: json["teacher_id"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "title": title,
        "description": description,
        "teacher_id": teacherId,
        "updated_at": updatedAt,
        "created_at": createdAt,
      };

  Class toEntity() {
    return Class(
        title: title,
        description: description,
        teacherId: teacherId,
        updatedAt: updatedAt,
        createdAt: createdAt,
        code: code);
  }
}
