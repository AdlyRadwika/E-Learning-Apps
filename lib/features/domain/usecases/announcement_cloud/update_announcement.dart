import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/repositories/firebase_announcement_cloud_repository.dart';

class UpdateAnnouncementUseCase {
  final FirebaseAnnouncementCloudRepository repository;

  const UpdateAnnouncementUseCase(this.repository);

  Future<Either<Failure, void>> execute({
    required String announcementId,
    required String content,
  }) {
    return repository.updateAnnouncement(
        announcementId: announcementId,
        content: content,
        );
  }
}
