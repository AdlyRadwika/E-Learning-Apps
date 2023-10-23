import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/assignment/students_assignment_status.dart';
import 'package:final_project/features/domain/repositories/firebase_assignment_cloud_repository.dart';

class GetUnsubmittedAssignmentsUseCase {
  final FirebaseAssignmentCloudRepository repository;

  const GetUnsubmittedAssignmentsUseCase(this.repository);

  Future<Either<Failure, List<StudentsAssignmentStatus>>> execute({
    required String assignmentId,
  }) {
    return repository.getUnsubmittedAssignments(assignmentId: assignmentId);
  }
}
