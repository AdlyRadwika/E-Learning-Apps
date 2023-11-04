import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/grade/grade_content.dart';
import 'package:final_project/features/domain/entities/grade/grade.dart';

abstract class FirebaseGradeCloudRepository {
  Future<Either<Failure, void>> insertGrade({
    required Grade data,
  });
  Future<Either<Failure, void>> updateGrade({
    required String gradeId,
    required int grade,
  });
  Future<Either<Failure, GradeContent>> getGradesByStudent({
    required String classCode,
    required String studentId,
  });
}
