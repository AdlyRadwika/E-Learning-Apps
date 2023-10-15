import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/repositories/firebase_class_cloud_repository.dart';

class CreateClassUseCase {
  final FirebaseClassCloudRepository repository;

  const CreateClassUseCase(this.repository);

  Future<Either<Failure, void>> execute({
    required String code,
    required String title,
    required String description,
    required String teacherId,
  }) {
    return repository.createClass(
        code: code,
        title: title,
        description: description,
        teacherId: teacherId);
  }
}
