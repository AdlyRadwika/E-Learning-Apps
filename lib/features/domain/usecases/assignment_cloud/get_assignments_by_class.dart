import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/data/models/assignment/assignment_model.dart';
import 'package:final_project/features/domain/repositories/firebase_assignment_cloud_repository.dart';

class GetAssignmentsByClassUseCase {
  final FirebaseAssignmentCloudRepository repository;

  const GetAssignmentsByClassUseCase(this.repository);

  Future<Either<Failure, Stream<QuerySnapshot<AssignmentModel>>>> execute({
    required String classCode,
  }) {
    return repository.getAssignmentsByClass(
      classCode: classCode,
    );
  }
}
