import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/class/class_user.dart';
import 'package:final_project/features/domain/repositories/firebase_class_cloud_repository.dart';

class GetClassStudentsUseCase {
  final FirebaseClassCloudRepository repository;

  const GetClassStudentsUseCase(this.repository);

  Future<Either<Failure, List<ClassUser>>> execute({
    required String classCode,
  }) {
    return repository.getClassStudents(classCode: classCode);
  }
}
