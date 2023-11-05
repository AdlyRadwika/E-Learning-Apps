import 'package:final_project/features/domain/entities/grade/grade_content.dart';

class GradeContentModel {
  final String id;
  final String classCode;
  final int finalGrade;
  final String updatedAt;
  final String createdAt;
  final GradeContentOwnerModel user;
  final List<AssignmentDetailModel> details;

  const GradeContentModel(
      {required this.id,
      required this.finalGrade,
      required this.updatedAt,
      required this.createdAt,
      required this.details,
      required this.user,
      required this.classCode});

  GradeContent toEntity() {
    return GradeContent(
        id: id,
        finalGrade: finalGrade,
        user: user.toEntity(),
        updatedAt: updatedAt,
        createdAt: createdAt,
        details: details.map((e) => e.toEntity()).toList(),
        classCode: classCode);
  }
}

class AssignmentDetailModel {
  final String assignmentId;
  final String assignmentName;
  int grade;
  final String fileUrl;
  final String fileName;
  final String submittedDate;

  AssignmentDetailModel({
    required this.assignmentId,
    required this.assignmentName,
    required this.fileUrl,
    this.grade = 0,
    required this.fileName,
    required this.submittedDate,
  });

  AssignmentDetail toEntity() {
    return AssignmentDetail(
      assignmentId: assignmentId,
      assignmentName: assignmentName,
      fileUrl: fileUrl,
      fileName: fileName,
      grade: grade,
      submittedDate: submittedDate,
    );
  }
}

class GradeContentOwnerModel {
  final String uid;
  final String name;
  final String imageUrl;

  const GradeContentOwnerModel({
    required this.uid,
    required this.name,
    required this.imageUrl,
  });

  GradeContentOwner toEntity() {
    return GradeContentOwner(uid: uid, name: name, imageUrl: imageUrl);
  }
}
