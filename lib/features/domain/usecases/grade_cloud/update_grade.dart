import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/repositories/firebase_grade_cloud_repository.dart';

class UpdateGradeUseCase {
  final FirebaseGradeCloudRepository repository;

  const UpdateGradeUseCase(this.repository);

  Future<Either<Failure, void>> execute({
    required String gradeId,
    required int grade,
  }) {
    return repository.updateGrade(gradeId: gradeId, grade: grade);
  }
}
