import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/repositories/firebase_assignment_cloud_repository.dart';

class DeleteAssignmentUseCase {
  final FirebaseAssignmentCloudRepository repository;

  const DeleteAssignmentUseCase(this.repository);

  Future<Either<Failure, void>> execute({
    required String assignmentId,
  }) {
    return repository.deleteAssignment(
      assignmentId: assignmentId,
    );
  }
}
