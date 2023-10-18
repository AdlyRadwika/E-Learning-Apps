import 'package:final_project/features/domain/entities/announcement/announcement.dart';

class AnnouncementModel {
  final String id;
  final String classCode;
  final String content;
  final String teacherId;
  final String updatedAt;
  final String createdAt;

  const AnnouncementModel(
      {required this.id,
      required this.content,
      required this.teacherId,
      required this.updatedAt,
      required this.createdAt,
      required this.classCode});

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      AnnouncementModel(
        classCode: json["class_code"],
        id: json["id"],
        content: json["content"],
        teacherId: json["teacher_id"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "class_code": classCode,
        "content": content,
        "teacher_id": teacherId,
        "updated_at": updatedAt,
        "created_at": createdAt,
      };

  Announcement toEntity() {
    return Announcement(
        id: id,
        content: content,
        teacherId: teacherId,
        updatedAt: updatedAt,
        createdAt: createdAt,
        classCode: classCode);
  }
}
