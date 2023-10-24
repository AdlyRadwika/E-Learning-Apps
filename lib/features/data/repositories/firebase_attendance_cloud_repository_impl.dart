import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/data/datasources/remote/firebase_attendance_cloud_remote.dart';
import 'package:final_project/features/domain/entities/attendance/attendance_content.dart';
import 'package:final_project/features/domain/entities/attendance/attendance.dart';
import 'package:final_project/features/domain/repositories/firebase_attendance_cloud_repository.dart';

class FirebaseAttendanceCloudRepositoryImpl
    implements FirebaseAttendanceCloudRepository {
  final FirebaseAttendanceCloudRemote remoteDataSource;

  FirebaseAttendanceCloudRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<AttendanceContent>>> getAttendancesByClass(
      {required String classCode}) async {
    try {
      final result =
          await remoteDataSource.getAttendancesByClass(classCode: classCode);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> insertAttendance(
      {required Attendance data}) async {
    try {
      final result =
          await remoteDataSource.insertAttendance(data: data.toModel());
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
