import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/grade/grade_content.dart';
import 'package:final_project/features/domain/repositories/firebase_grade_cloud_repository.dart';

class GetGradesByStudentUseCase {
  final FirebaseGradeCloudRepository repository;

  const GetGradesByStudentUseCase(this.repository);

  Future<Either<Failure, GradeContent>> execute({
    required String classCode,
    required String studentId,
  }) {
    return repository.getGradesByStudent(
        classCode: classCode, studentId: studentId);
  }
}
