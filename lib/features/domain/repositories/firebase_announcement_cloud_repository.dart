import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/announcement/announcement_content.dart';

abstract class FirebaseAnnouncementCloudRepository {
  Future<Either<Failure, void>> insertAnnouncement({
    required String announcementId,
    required String teacherId,
    required String content,
    required String classCode,
  });
  Future<Either<Failure, void>> updateAnnouncement({
    required String announcementId,
    required String content,
  });
  Future<Either<Failure, void>> deleteAnnouncement({
    required String announcementId,
  });
  Future<Either<Failure, List<AnnouncementContent>>> getAnnouncementsByUid({
    required String uid,
  });
}
