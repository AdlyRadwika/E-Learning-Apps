import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/data/models/assignment/assignment_model.dart';
import 'package:final_project/features/data/models/assignment/submission_model.dart';
import 'package:final_project/features/domain/entities/assignment/assignment.dart';
import 'package:final_project/features/domain/entities/assignment/students_assignment_status.dart';
import 'package:final_project/features/domain/entities/assignment/submission.dart';

abstract class FirebaseAssignmentCloudRepository {
  Future<Either<Failure, void>> insertAssignment({required Assignment data});
  Future<Either<Failure, void>> updateAssignment({required Assignment data});
  Future<Either<Failure, void>> deleteAssignment({
    required String assignmentId,
  });
  Future<Either<Failure, Stream<QuerySnapshot<AssignmentModel>>>>
      getAssignmentsByClass({
    required String classCode,
  });
  Future<Either<Failure, Submission>> getSubmissionFile(
      {required File file,
      required String studentId,
      required String assignmentId});
  Future<Either<Failure, void>> uploadSubmission({required Submission data});
  Future<Either<Failure, Stream<QuerySnapshot<SubmissionModel>>>>
      getSubmissionStatus(
          {required String assignmentId, required String studentId});
  Future<Either<Failure, List<StudentsAssignmentStatus>>>
      getSubmittedAssignments({
    required String assignmentId,
  });
  Future<Either<Failure, List<StudentsAssignmentStatus>>>
      getUnsubmittedAssignments({
    required String assignmentId,
  });
  Future<Either<Failure, List<Assignment>>> getAssignmentSchedules(
      {required String studentId});
  Future<Either<Failure, List<Assignment>>> getTeacherSchedules(
      {required String teacherId});
}
