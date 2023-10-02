class UserModel {
  final String uid;
  final String name;
  final String email;
  final String imageUrl;
  final List imageData;
  final String role;
  final DateTime updatedAt;
  final DateTime createdAt;

  const UserModel(
      {required this.name,
      required this.email,
      required this.imageUrl,
      required this.imageData,
      required this.role,
      required this.updatedAt,
      required this.createdAt,
      required this.uid});

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "role": role,
        "image_url": imageUrl,
        "image_data": imageData,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
      };
}
