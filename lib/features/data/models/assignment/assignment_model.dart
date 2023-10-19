import 'package:final_project/features/domain/entities/assignment/assignment.dart';

class AssignmentModel {
  final String id;
  final String classCode;
  final String title;
  final String description;
  final String teacherId;
  final String deadline;
  final String updatedAt;
  final String createdAt;

  const AssignmentModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.teacherId,
      required this.deadline,
      required this.updatedAt,
      required this.createdAt,
      required this.classCode});

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      AssignmentModel(
        classCode: json["class_code"],
        id: json["id"],
        title: json["title"],
        description: json["description"],
        deadline: json["deadline"],
        teacherId: json["teacher_id"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "class_code": classCode,
        "title": title,
        "description": description,
        "deadline": deadline,
        "teacher_id": teacherId,
        "updated_at": updatedAt,
        "created_at": createdAt,
      };

  Assignment toEntity() {
    return Assignment(
        id: id,
        title: title,
        description: description,
        teacherId: teacherId,
        deadline: deadline,
        updatedAt: updatedAt,
        createdAt: createdAt,
        classCode: classCode);
  }
}
