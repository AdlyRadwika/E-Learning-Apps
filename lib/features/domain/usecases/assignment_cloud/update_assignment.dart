import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/assignment/assignment.dart';
import 'package:final_project/features/domain/repositories/firebase_assignment_cloud_repository.dart';

class UpdateAssignmentUseCase {
  final FirebaseAssignmentCloudRepository repository;

  const UpdateAssignmentUseCase(this.repository);

  Future<Either<Failure, void>> execute({
    required Assignment data,
  }) {
    return repository.updateAssignment(
      data: data,
    );
  }
}
