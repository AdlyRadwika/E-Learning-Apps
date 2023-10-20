import 'package:final_project/features/domain/entities/assignment/submission.dart';

class SubmissionModel {
  final String id;
  final String assignmentId;
  final String fileUrl;
  final String fileName;
  final String studentId;
  final String updatedAt;
  final String createdAt;

  const SubmissionModel(
      {required this.id,
      required this.fileUrl,
      required this.fileName,
      required this.studentId,
      required this.updatedAt,
      required this.createdAt,
      required this.assignmentId});

  factory SubmissionModel.fromJson(Map<String, dynamic> json) =>
      SubmissionModel(
        assignmentId: json["assignment_id"],
        id: json["id"],
        fileUrl: json["file_url"],
        fileName: json["file_name"],
        studentId: json["teacher_id"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "assignment_id": assignmentId,
        "file_url": fileUrl,
        "file_name": fileName,
        "teacher_id": studentId,
        "updated_at": updatedAt,
        "created_at": createdAt,
      };

  Submission toEntity() {
    return Submission(
        id: id,
        fileUrl: fileUrl,
        fileName: fileName,
        studentId: studentId,
        updatedAt: updatedAt,
        createdAt: createdAt,
        assignmentId: assignmentId);
  }
}
