import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/repositories/firebase_announcement_cloud_repository.dart';

class InsertAnnouncementUseCase {
  final FirebaseAnnouncementCloudRepository repository;

  const InsertAnnouncementUseCase(this.repository);

  Future<Either<Failure, void>> execute({
    required String announcementId,
    required String teacherId,
    required String content,
    required String classCode,
  }) {
    return repository.insertAnnouncement(
        announcementId: announcementId,
        teacherId: teacherId,
        content: content,
        classCode: classCode);
  }
}
