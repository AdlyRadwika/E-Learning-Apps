import 'package:final_project/features/data/models/assignment/submission_model.dart';

class Submission {
  final String id;
  final String assignmentId;
  final String fileUrl;
  final String fileName;
  final String studentId;
  final String updatedAt;
  final String createdAt;

  const Submission(
      {required this.id,
      required this.fileUrl,
      required this.fileName,
      required this.studentId,
      required this.updatedAt,
      required this.createdAt,
      required this.assignmentId});

  SubmissionModel toModel() {
    return SubmissionModel(
        id: id,
        fileUrl: fileUrl,
        fileName: fileName,
        studentId: studentId,
        updatedAt: updatedAt,
        createdAt: createdAt,
        assignmentId: assignmentId);
  }
}
