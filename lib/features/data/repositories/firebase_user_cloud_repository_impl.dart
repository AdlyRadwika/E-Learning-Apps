import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/data/datasources/remote/firebase_user_cloud_remote.dart';
import 'package:final_project/features/domain/entities/user/user.dart';
import 'package:final_project/features/domain/repositories/firebase_user_cloud_repository.dart';

class FirebaseUserCloudRepositoryImpl implements FirebaseUserCloudRepository {
  final FirebaseUserCloudRemote remoteDataSource;

  FirebaseUserCloudRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> insertUserData(
      {required String uid,
      required String email,
      required String userName,
      required List imageData,
      required String imageUrl,
      required String role}) async {
    try {
      final result = await remoteDataSource.insertUserData(
        uid: uid,
        email: email,
        imageData: imageData,
        imageUrl: imageUrl,
        userName: userName,
        role: role,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getUserById({
    required String uid,
  }) async {
    try {
      final result = await remoteDataSource.getUserById(
        uid: uid,
      );
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getPhotoProfileUrl(
      {required File file}) async {
    try {
      final result = await remoteDataSource.getPhotoProfileUrl(
        file: file,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
