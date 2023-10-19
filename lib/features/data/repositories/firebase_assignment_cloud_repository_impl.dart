import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/data/datasources/remote/firebase_assignment_cloud_remote.dart';
import 'package:final_project/features/data/models/assignment/assignment_model.dart';
import 'package:final_project/features/domain/entities/assignment/assignment.dart';
import 'package:final_project/features/domain/repositories/firebase_assignment_cloud_repository.dart';

class FirebaseAssignmentCloudRepositoryImpl
    implements FirebaseAssignmentCloudRepository {
  final FirebaseAssignmentCloudRemote remoteDataSource;

  FirebaseAssignmentCloudRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> deleteAssignment(
      {required String assignmentId}) async {
    try {
      final result =
          await remoteDataSource.deleteAssignment(assignmentId: assignmentId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot<AssignmentModel>>>>
      getAssignmentsByClass({required String classCode}) async {
    try {
      final result =
          await remoteDataSource.getAssignmentsByClass(classCode: classCode);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> insertAssignment(
      {required Assignment data}) async {
    try {
      final result =
          await remoteDataSource.insertAssignment(data: data.toModel());
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateAssignment(
      {required Assignment data}) async {
    try {
      final result =
          await remoteDataSource.insertAssignment(data: data.toModel());
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
