import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/data/models/attendance/attendance_model.dart';
import 'package:final_project/features/domain/entities/attendance/attendance.dart';
import 'package:final_project/features/domain/entities/attendance/attendance_content.dart';

abstract class FirebaseAttendanceCloudRepository {
  Future<Either<Failure, void>> insertAttendance({
    required Attendance data,
  });
  Future<Either<Failure, List<AttendanceContent>>> getAttendancesByClass({
    required String classCode,
  });
  Future<Either<Failure, Stream<QuerySnapshot<AttendanceModel>>>> getAttendanceStatus(
      {required String classCode, required String studentId});
}
