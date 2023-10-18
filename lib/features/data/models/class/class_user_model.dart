import 'package:final_project/features/domain/entities/class/class_user.dart';

class ClassUserModel {
  final String uid;
  final String name;
  final String imageUrl;
  final String role;
  final String joinedAt;

  const ClassUserModel(
      {required this.name,
      required this.imageUrl,
      required this.role,
      required this.joinedAt,
      required this.uid});

  ClassUser toEntity() {
    return ClassUser(
        name: name,
        imageUrl: imageUrl,
        role: role,
        joinedAt: joinedAt,
        uid: uid);
  }
}
