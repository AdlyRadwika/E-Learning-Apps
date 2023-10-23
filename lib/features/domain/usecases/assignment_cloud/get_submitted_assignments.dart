import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/assignment/students_assignment_status.dart';
import 'package:final_project/features/domain/repositories/firebase_assignment_cloud_repository.dart';

class GetSubmittedAssignmentsUseCase {
  final FirebaseAssignmentCloudRepository repository;

  const GetSubmittedAssignmentsUseCase(this.repository);

  Future<Either<Failure, List<StudentsAssignmentStatus>>> execute({
    required String assignmentId,
  }) {
    return repository.getSubmittedAssignments(assignmentId: assignmentId);
  }
}
