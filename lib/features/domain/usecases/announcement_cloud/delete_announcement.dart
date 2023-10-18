import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/repositories/firebase_announcement_cloud_repository.dart';

class DeleteAnnouncementUseCase {
  final FirebaseAnnouncementCloudRepository repository;

  const DeleteAnnouncementUseCase(this.repository);

  Future<Either<Failure, void>> execute({
    required String announcementId,
  }) {
    return repository.deleteAnnouncement(
      announcementId: announcementId,
    );
  }
}
