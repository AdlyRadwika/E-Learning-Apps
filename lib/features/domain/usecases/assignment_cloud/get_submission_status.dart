import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/data/models/assignment/submission_model.dart';
import 'package:final_project/features/domain/repositories/firebase_assignment_cloud_repository.dart';

class GetSubmissionStatusUseCase {
  final FirebaseAssignmentCloudRepository repository;

  const GetSubmissionStatusUseCase(this.repository);

  Future<Either<Failure, Stream<QuerySnapshot<SubmissionModel>>>> execute(
      {required String studentId, required String assignmentId}) {
    return repository.getSubmissionStatus(
        assignmentId: assignmentId, studentId: studentId);
  }
}
