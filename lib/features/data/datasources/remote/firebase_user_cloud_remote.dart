import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/features/data/models/user/user_model.dart';

abstract class FirebaseUserCloudRemote {
  Future<void> insertUserData(
      {required String uid,
      required String email,
      required String userName,
      required List imageData,
      String imageUrl = '',
      required String role});
  Future<UserModel> getUserById({
    required String uid,
  });
}

class FirebaseUserCloudRemoteImpl implements FirebaseUserCloudRemote {
  final studentRef = 'student';
  final teacherRef = 'teacher';

  CollectionReference _userCollection() {
    return FirebaseFirestore.instance
        .collection('users')
        .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (value, _) => value.toJson());
  }

  @override
  Future<void> insertUserData(
      {required String uid,
      required String email,
      required String userName,
      required List imageData,
      String imageUrl = '',
      required String role}) async {
    try {
      final data = UserModel(
          name: userName,
          email: email,
          imageUrl: imageUrl,
          imageData: imageData,
          role: role,
          updatedAt: DateTime.now().toIso8601String(),
          createdAt: DateTime.now().toIso8601String(),
          uid: uid);
      await _userCollection().doc(uid).set(data);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserModel> getUserById({
    required String uid,
  }) async {
    try {
      final result = await _userCollection().doc(uid).get();
      return result.data() as UserModel;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
