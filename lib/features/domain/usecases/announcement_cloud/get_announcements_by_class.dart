import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/announcement/announcement_content.dart';
import 'package:final_project/features/domain/repositories/firebase_announcement_cloud_repository.dart';

class GetAnnouncementsByClassUseCase {
  final FirebaseAnnouncementCloudRepository repository;

  const GetAnnouncementsByClassUseCase(this.repository);

  Future<Either<Failure, List<AnnouncementContent>>> execute({
    required String classCode,
  }) {
    return repository.getAnnouncementsByClass(classCode: classCode);
  }
}
