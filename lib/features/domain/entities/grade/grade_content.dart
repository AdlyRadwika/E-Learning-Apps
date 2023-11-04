class GradeContent {
  final String id;
  final String classCode;
  final int finalGrade;
  final String updatedAt;
  final String createdAt;
  final GradeContentOwner user;
  final List<AssignmentDetail> details;

  const GradeContent(
      {required this.id,
      required this.finalGrade,
      required this.updatedAt,
      required this.createdAt,
      required this.details,
      required this.user,
      required this.classCode});
}

class AssignmentDetail {
  final String assignmentId;
  final String assignmentName;
  final int grade;
  final String fileUrl;
  final String fileName;
  final String submittedDate;

  const AssignmentDetail({
    required this.assignmentId,
    required this.assignmentName,
    required this.fileUrl,
    required this.grade,
    required this.fileName,
    required this.submittedDate,
  });
}

class GradeContentOwner {
  final String uid;
  final String name;
  final String imageUrl;

  const GradeContentOwner({
    required this.uid,
    required this.name,
    required this.imageUrl,
  });
}
