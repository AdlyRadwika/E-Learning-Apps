import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/attendance/attendance.dart';
import 'package:final_project/features/domain/entities/attendance/attendance_content.dart';

abstract class FirebaseAttendanceCloudRepository {
  Future<Either<Failure, void>> insertAttendance({
    required Attendance data,
  });
  Future<Either<Failure, List<AttendanceContent>>> getAttendancesByClass({
    required String classCode,
  });
}
