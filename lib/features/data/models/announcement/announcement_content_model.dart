import 'package:final_project/features/domain/entities/announcement/announcement_content.dart';

class AnnouncementContentModel {
  final String id;
  final String classCode;
  final String content;
  final String updatedAt;
  final String createdAt;
  final AnnouncementOwnerModel owner;

  const AnnouncementContentModel(
      {required this.id,
      required this.content,
      required this.updatedAt,
      required this.createdAt,
      required this.owner,
      required this.classCode});

  AnnouncementContent toEntity() {
    return AnnouncementContent(
        id: id,
        content: content,
        updatedAt: updatedAt,
        createdAt: createdAt,
        owner: owner.toEntity(),
        classCode: classCode);
  }
}

class AnnouncementOwnerModel {
  final String uid;
  final String name;
  final String imageUrl;

  const AnnouncementOwnerModel({
    required this.uid,
    required this.name,
    required this.imageUrl,
  });

  AnnouncementOwner toEntity() {
    return AnnouncementOwner(uid: uid, name: name, imageUrl: imageUrl);
  }
}
