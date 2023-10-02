import 'package:final_project/features/domain/entities/user/user.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String imageUrl;
  final List imageData;
  final String role;
  final String updatedAt;
  final String createdAt;

  const UserModel(
      {required this.name,
      required this.email,
      required this.imageUrl,
      required this.imageData,
      required this.role,
      required this.updatedAt,
      required this.createdAt,
      required this.uid});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        imageUrl: json["image_url"],
        imageData: json["image_data"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "role": role,
        "image_url": imageUrl,
        "image_data": imageData,
        "updated_at": updatedAt,
        "created_at": createdAt,
      };


  User toEntity() {
    return User(
        name: name,
        email: email,
        imageUrl: imageUrl,
        imageData: imageData,
        role: role,
        updatedAt: updatedAt,
        createdAt: createdAt,
        uid: uid);
  }
}
