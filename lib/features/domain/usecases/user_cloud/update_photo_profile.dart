import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/repositories/firebase_user_cloud_repository.dart';

class UpdatePhotoProfileUseCase {
  final FirebaseUserCloudRepository repository;

  const UpdatePhotoProfileUseCase(this.repository);

  Future<Either<Failure, void>> execute({
    required String uid,
    required String imageUrl,
    required List imageData,
  }) {
    return repository.updatePhotoProfile(
        uid: uid, imageUrl: imageUrl, imageData: imageData);
  }
}
