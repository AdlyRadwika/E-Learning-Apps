import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/repositories/firebase_auth_repository.dart';

class ResetPasswordUseCase {
  final FirebaseAuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<Failure, void>> execute({
    required String email,
  }) {
    return repository.resetPassword(
      email: email,
    );
  }
}
