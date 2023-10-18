import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/data/datasources/remote/firebase_announcement_cloud_remote.dart';
import 'package:final_project/features/domain/entities/announcement/announcement.dart';
import 'package:final_project/features/domain/repositories/firebase_announcement_cloud_repository.dart';

class FirebaseAnnouncementCloudRepositoryImpl
    implements FirebaseAnnouncementCloudRepository {
  final FirebaseAnnouncementCloudRemote remoteDataSource;

  FirebaseAnnouncementCloudRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> deleteAnnouncement(
      {required String announcementId}) async {
    try {
      final result = await remoteDataSource.deleteAnnouncement(
          announcementId: announcementId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Announcement>>> getAnnouncementsByUid(
      {required String uid}) async {
    try {
      final result = await remoteDataSource.getAnnouncementsByUid(uid: uid);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> insertAnnouncement(
      {required String announcementId,
      required String teacherId,
      required String content,
      required String classCode}) async {
    try {
      final result = await remoteDataSource.insertAnnouncement(
          announcementId: announcementId,
          teacherId: teacherId,
          content: content,
          classCode: classCode);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateAnnouncement(
      {required String announcementId, required String content}) async {
    try {
      final result = await remoteDataSource.updateAnnouncement(
          announcementId: announcementId, content: content);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
