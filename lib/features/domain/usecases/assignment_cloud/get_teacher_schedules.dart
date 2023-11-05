import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/assignment/assignment.dart';
import 'package:final_project/features/domain/repositories/firebase_assignment_cloud_repository.dart';

class GetTeacherSchedulesUseCase {
  final FirebaseAssignmentCloudRepository repository;

  const GetTeacherSchedulesUseCase(this.repository);

  Future<Either<Failure, List<Assignment>>> execute({
    required String teacherId,
  }) {
    return repository.getTeacherSchedules(teacherId: teacherId);
  }
}
