class AnnouncementContent {
  final String id;
  final String classCode;
  final String content;
  final String updatedAt;
  final String createdAt;
  final AnnouncementOwner owner;

  const AnnouncementContent(
      {required this.id,
      required this.content,
      required this.updatedAt,
      required this.createdAt,
      required this.owner,
      required this.classCode});
}

class AnnouncementOwner {
  final String uid;
  final String name;
  final String imageUrl;

  const AnnouncementOwner({
    required this.uid,
    required this.name,
    required this.imageUrl,
  });
}
