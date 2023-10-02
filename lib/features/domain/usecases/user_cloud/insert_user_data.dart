import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/repositories/firebase_user_cloud_repository.dart';

class InsertUserDataUseCase {
  final FirebaseUserCloudRepository repository;

  const InsertUserDataUseCase(this.repository);

  Future<Either<Failure, void>> execute(
      {required String uid,
      required String email,
      required String userName,
      required List imageData,
      required String imageUrl,
      required String role}) {
    return repository.insertUserData(
        uid: uid,
        email: email,
        userName: userName,
        role: role,
        imageData: imageData,
        imageUrl: imageUrl);
  }
}
