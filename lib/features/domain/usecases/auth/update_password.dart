import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/repositories/firebase_auth_repository.dart';

class UpdatePasswordUseCase {
  final FirebaseAuthRepository repository;

  UpdatePasswordUseCase(this.repository);

  Future<Either<Failure, void>> execute({
    required String email,
    required String oldPass,
    required String newPass,
  }) {
    return repository.updatePassword(
      email: email,
      newPass: newPass,
      oldPass: oldPass,
    );
  }
}
