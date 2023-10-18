import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/repositories/firebase_class_cloud_repository.dart';

class JoinClassUseCase {
  final FirebaseClassCloudRepository repository;

  const JoinClassUseCase(this.repository);

  Future<Either<Failure, void>> execute({
    required String code,
    required String uid,
  }) {
    return repository.joinClass(
      code: code,
      uid: uid,
    );
  }
}
