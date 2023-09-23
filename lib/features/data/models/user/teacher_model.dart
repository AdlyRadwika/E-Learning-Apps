class TeacherModel {
  final String uid;
  final String name;
  final String email;
  final String imageUrl;
  final DateTime updatedAt;
  final DateTime createdAt;

  const TeacherModel(
      {required this.name,
      required this.email,
      required this.imageUrl,
      required this.updatedAt,
      required this.createdAt,
      required this.uid});

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "name": name,
    "email": email,
    "image_url": imageUrl,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
  };
}
