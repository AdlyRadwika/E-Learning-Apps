import 'package:final_project/features/domain/entities/assignment/students_assignment_status.dart';

class StudentsAssignmentStatusModel {
  final String studentName;
  final String fileUrl;
  final String submittedDate;

  const StudentsAssignmentStatusModel({
    required this.studentName,
    required this.fileUrl,
    required this.submittedDate,
  });

  StudentsAssignmentStatus toEntity() {
    return StudentsAssignmentStatus(
        studentName: studentName,
        fileUrl: fileUrl,
        submittedDate: submittedDate);
  }
}
