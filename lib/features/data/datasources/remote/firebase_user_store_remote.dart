import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/features/data/models/user/user_model.dart';

abstract class FirebaseUserStoreRemote {
  Future<void> insertUserData(
      {required String uid,
      required String email,
      required String userName,
      required List imageData,
      String imageUrl = '',
      required String role});
}

class FirebaseUserStoreRemoteImpl implements FirebaseUserStoreRemote {
  final firestore = FirebaseFirestore.instance;
  final studentRef = 'student';
  final teacherRef = 'teacher';

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
          updatedAt: DateTime.now(),
          createdAt: DateTime.now(),
          uid: uid);
      if (role == studentRef) {
        await firestore.collection(studentRef).doc(uid).set(data.toJson());
      } else {
        await firestore.collection(teacherRef).doc(uid).set(data.toJson());
      }
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
