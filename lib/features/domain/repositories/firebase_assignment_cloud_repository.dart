import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/data/models/assignment/assignment_model.dart';
import 'package:final_project/features/domain/entities/assignment/assignment.dart';

abstract class FirebaseAssignmentCloudRepository {
  Future<Either<Failure, void>> insertAssignment({required Assignment data});
  Future<Either<Failure, void>> updateAssignment({required Assignment data});
  Future<Either<Failure, void>> deleteAssignment({
    required String assignmentId,
  });
  Future<Either<Failure, Stream<QuerySnapshot<AssignmentModel>>>> getAssignmentsByClass({
    required String classCode,
  });
}
