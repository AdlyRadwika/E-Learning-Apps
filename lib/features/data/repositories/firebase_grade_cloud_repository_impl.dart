import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/data/datasources/remote/firebase_grade_cloud_remote.dart';
import 'package:final_project/features/domain/entities/grade/grade.dart';
import 'package:final_project/features/domain/entities/grade/grade_content.dart';
import 'package:final_project/features/domain/repositories/firebase_grade_cloud_repository.dart';

class FirebaseGradeCloudRepositoryImpl implements FirebaseGradeCloudRepository {
  final FirebaseGradeCloudRemote remoteDataSource;

  FirebaseGradeCloudRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, GradeContent>> getGradesByStudent(
      {required String classCode, required String studentId}) async {
    try {
      final result = await remoteDataSource.getGradesByStudent(
          classCode: classCode, studentId: studentId);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> insertGrade({required Grade data}) async {
    try {
      final result = await remoteDataSource.insertGrade(data: data.toModel());
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateGrade(
      {required String gradeId, required int grade}) async {
    try {
      final result =
          await remoteDataSource.updateGrade(gradeId: gradeId, grade: grade);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
