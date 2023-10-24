import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/attendance/attendance.dart';
import 'package:final_project/features/domain/repositories/firebase_attendance_cloud_repository.dart';

class InsertAttendanceUseCase {
  final FirebaseAttendanceCloudRepository repository;

  const InsertAttendanceUseCase(this.repository);

  Future<Either<Failure, void>> execute({
    required Attendance data,
  }) {
    return repository.insertAttendance(
      data: data,
    );
  }
}
