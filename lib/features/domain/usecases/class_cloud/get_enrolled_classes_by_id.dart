import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/class/enrolled_class.dart';
import 'package:final_project/features/domain/repositories/firebase_class_cloud_repository.dart';

class GetEnrolledClassesByIdUseCase {
  final FirebaseClassCloudRepository repository;

  const GetEnrolledClassesByIdUseCase(this.repository);

  Future<Either<Failure, List<EnrolledClass>>> execute({
    required String uid,
  }) {
    return repository.getEnrolledClassesByUid(
      userId: uid,
    );
  }
}
