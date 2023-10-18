import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/class/class.dart';
import 'package:final_project/features/domain/entities/class/enrolled_class.dart';

abstract class FirebaseClassCloudRepository {
  Future<Either<Failure, void>> createClass({
    required String code,
    required String title,
    required String description,
    required String teacherId,
  });
  Future<Either<Failure, List<Class>>> getClassesByUid({required String userId});
    Future<Either<Failure, void>> joinClass({required String code, required String uid});
  Future<Either<Failure, List<EnrolledClass>>> getEnrolledClassesByUid({
    required String userId,
  });
}
