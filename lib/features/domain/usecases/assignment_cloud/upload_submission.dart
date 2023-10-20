import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/assignment/submission.dart';
import 'package:final_project/features/domain/repositories/firebase_assignment_cloud_repository.dart';

class UploadSubmissionUseCase {
  final FirebaseAssignmentCloudRepository repository;

  const UploadSubmissionUseCase(this.repository);

  Future<Either<Failure, void>> execute({
    required Submission data,
  }) {
    return repository.uploadSubmission(
      data: data,
    );
  }
}
