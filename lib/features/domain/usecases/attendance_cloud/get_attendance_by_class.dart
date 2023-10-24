import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/attendance/attendance_content.dart';
import 'package:final_project/features/domain/repositories/firebase_attendance_cloud_repository.dart';

class GetAttendancesByClassUseCase {
  final FirebaseAttendanceCloudRepository repository;

  const GetAttendancesByClassUseCase(this.repository);

  Future<Either<Failure, List<AttendanceContent>>> execute({
    required String classCode,
  }) {
    return repository.getAttendancesByClass(
      classCode: classCode,
    );
  }
}
