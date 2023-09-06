import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';

abstract class FirebaseAuthRepository {
  Future<Either<Failure, void>> login(
      {required String email, required String password});
  Future<Either<Failure, void>> register(
      {required String email, required String password});
  Future<Either<Failure, void>> logout();
}
