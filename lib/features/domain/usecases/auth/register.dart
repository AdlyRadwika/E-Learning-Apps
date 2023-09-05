import 'package:dartz/dartz.dart';
import 'package:final_project/common/failure.dart';
import 'package:final_project/features/domain/repositories/firebase_auth_repository.dart';

class RegisterUseCase {
  final FirebaseAuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, void>> execute({
    required String email,
    required String password,
  }) {
    return repository.register(email: email, password: password);
  }
}
