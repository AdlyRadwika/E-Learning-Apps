import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/data/models/class/class_model.dart';
import 'package:final_project/features/data/models/class/enrolled_class_model.dart';
import 'package:final_project/features/domain/entities/class/class_user.dart';

abstract class FirebaseClassCloudRepository {
  Future<Either<Failure, void>> createClass({
    required String code,
    required String title,
    required String description,
    required String teacherId,
  });
  Future<Either<Failure, Stream<QuerySnapshot<ClassModel>>>> getClassesByUid({required String userId});
    Future<Either<Failure, void>> joinClass({required String code, required String uid});
  Future<Either<Failure, Stream<QuerySnapshot<EnrolledClassModel>>>> getEnrolledClassesByUid({
    required String userId,
  });
  Future<Either<Failure, ClassUser>> getClassTeacher({required String classCode});
  Future<Either<Failure, List<ClassUser>>> getClassStudents({required String classCode});
}
