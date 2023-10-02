import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthRepository {
  Future<Either<Failure, void>> login(
      {required String email, required String password});
  Future<Either<Failure, User?>> register(
      {required String email, required String password, required String userName, required String role});
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> resetPassword({required String email});
}
