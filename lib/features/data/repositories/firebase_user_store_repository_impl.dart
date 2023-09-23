import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/data/datasources/remote/firebase_user_store_remote.dart';
import 'package:final_project/features/domain/repositories/firebase_user_store_repository.dart';

class FirebaseUserStoreRepositoryImpl implements FirebaseUserStoreRepository {
  final FirebaseUserStoreRemote remoteDataSource;

  FirebaseUserStoreRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> insertUserData(
      {required String uid,
      required String email,
      required String userName,
      required String role}) async {
    try {
      final result = await remoteDataSource.insertUserData(
          uid: uid,
          email: email,
          userName: userName,
          role: role);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
