class Announcement {
  final String id;
  final String classCode;
  final String content;
  final String teacherId;
  final String updatedAt;
  final String createdAt;

  const Announcement(
      {required this.id,
      required this.content,
      required this.teacherId,
      required this.updatedAt,
      required this.createdAt,
      required this.classCode});


}
