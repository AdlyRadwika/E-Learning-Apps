import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/data/datasources/remote/firebase_class_cloud_remote.dart';
import 'package:final_project/features/domain/entities/class/class.dart';
import 'package:final_project/features/domain/repositories/firebase_class_cloud_repository.dart';

class FirebaseClassCloudRepositoryImpl implements FirebaseClassCloudRepository {
  final FirebaseClassCloudRemote remote;

  FirebaseClassCloudRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, void>> createClass(
      {required String code,
      required String title,
      required String description,
      required String teacherId}) async {
    try {
      final result = await remote.createClass(
          code: code,
          title: title,
          description: description,
          teacherId: teacherId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Class>>> getClassesByUid(
      {required String userId}) async {
    try {
      final result = await remote.getClassesByUid(userId: userId);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}