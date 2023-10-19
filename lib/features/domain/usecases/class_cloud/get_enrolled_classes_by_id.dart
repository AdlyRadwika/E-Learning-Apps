import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/data/models/class/enrolled_class_model.dart';
import 'package:final_project/features/domain/repositories/firebase_class_cloud_repository.dart';

class GetEnrolledClassesByIdUseCase {
  final FirebaseClassCloudRepository repository;

  const GetEnrolledClassesByIdUseCase(this.repository);

  Future<Either<Failure, Stream<QuerySnapshot<EnrolledClassModel>>>> execute({
    required String uid,
  }) {
    return repository.getEnrolledClassesByUid(
      userId: uid,
    );
  }
}
