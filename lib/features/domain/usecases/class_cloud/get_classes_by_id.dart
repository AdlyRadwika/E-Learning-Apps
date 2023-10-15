import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/class/class.dart';
import 'package:final_project/features/domain/repositories/firebase_class_cloud_repository.dart';

class GetClassesByIdUseCase {
  final FirebaseClassCloudRepository repository;

  const GetClassesByIdUseCase(this.repository);

  Future<Either<Failure, List<Class>>> execute({
    required String uid,
  }) {
    return repository.getClassesByUid(
      userId: uid,
    );
  }
}
