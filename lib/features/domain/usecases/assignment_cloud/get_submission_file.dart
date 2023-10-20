import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/assignment/submission.dart';
import 'package:final_project/features/domain/repositories/firebase_assignment_cloud_repository.dart';

class GetSubmissionFileUseCase {
  final FirebaseAssignmentCloudRepository repository;

  const GetSubmissionFileUseCase(this.repository);

  Future<Either<Failure, Submission>> execute(
      {required File file,
      required String studentId,
      required String assignmentId}) {
    return repository.getSubmissionFile(
        file: file, studentId: studentId, assignmentId: assignmentId);
  }
}
