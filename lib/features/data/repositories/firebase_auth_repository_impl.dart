import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/data/datasources/remote/firebase_auth_remote.dart';
import 'package:final_project/features/domain/repositories/firebase_auth_repository.dart';

class FirebaseAuthRepositoryImpl implements FirebaseAuthRepository {
  final FirebaseAuthRemoteData remoteDataSource;

  FirebaseAuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> login(
      {required String email, required String password}) async {
    try {
      final result =
          await remoteDataSource.login(email: email, password: password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = await remoteDataSource.logout();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> register(
      {required String email, required String password}) async {
    try {
      final result =
          await remoteDataSource.register(email: email, password: password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
