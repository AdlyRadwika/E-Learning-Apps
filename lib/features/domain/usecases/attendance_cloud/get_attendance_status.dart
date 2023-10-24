import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/data/models/attendance/attendance_model.dart';
import 'package:final_project/features/domain/repositories/firebase_attendance_cloud_repository.dart';

class GetAttendanceStatusUseCase {
  final FirebaseAttendanceCloudRepository repository;

  const GetAttendanceStatusUseCase(this.repository);

  Future<Either<Failure, Stream<QuerySnapshot<AttendanceModel>>>> execute(
      {required String classCode, required String studentId}) {
    return repository.getAttendanceStatus(
        classCode: classCode, studentId: studentId);
  }
}
