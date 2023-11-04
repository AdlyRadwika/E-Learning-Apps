import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/grade/grade.dart';
import 'package:final_project/features/domain/repositories/firebase_grade_cloud_repository.dart';

class InsertGradeUseCase {
  final FirebaseGradeCloudRepository repository;

  const InsertGradeUseCase(this.repository);

  Future<Either<Failure, void>> execute({
    required Grade data,
  }) {
    return repository.insertGrade(data: data);
  }
}
