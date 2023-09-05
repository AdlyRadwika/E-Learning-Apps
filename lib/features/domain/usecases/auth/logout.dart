import 'package:dartz/dartz.dart';
import 'package:final_project/common/failure.dart';
import 'package:final_project/features/domain/repositories/firebase_auth_repository.dart';

class LogoutUseCase {
  final FirebaseAuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, void>> execute() {
    return repository.logout();
  }
}
