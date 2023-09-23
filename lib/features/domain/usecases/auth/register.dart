import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/repositories/firebase_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterUseCase {
  final FirebaseAuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, User?>> execute({
    required String email,
    required String password,
    required String userName,
    required String role,
  }) {
    return repository.register(email: email, password: password, userName: userName, role: role);
  }
}
