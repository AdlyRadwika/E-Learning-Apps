import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/user/user.dart';
import 'package:final_project/features/domain/repositories/firebase_user_cloud_repository.dart';

class GetUserByIdUseCase {
  final FirebaseUserCloudRepository repository;

  const GetUserByIdUseCase(this.repository);

  Future<Either<Failure, User>> execute({
    required String uid,
  }) {
    return repository.getUserById(
      uid: uid,
    );
  }
}
