import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/data/models/class/class_model.dart';
import 'package:final_project/features/domain/repositories/firebase_class_cloud_repository.dart';

class GetClassesByIdUseCase {
  final FirebaseClassCloudRepository repository;

  const GetClassesByIdUseCase(this.repository);

  Future<Either<Failure, Stream<QuerySnapshot<ClassModel>>>> execute({
    required String uid,
  }) {
    return repository.getClassesByUid(
      userId: uid,
    );
  }
}
