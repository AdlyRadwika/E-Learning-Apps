import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/features/data/models/user/student_model.dart';
import 'package:final_project/features/data/models/user/teacher_model.dart';

abstract class FirebaseUserStoreRemote {
  Future<void> insertUserData(
      {required String uid,
      required String email,
      required String userName,
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
      required String role}) async {
    try {
      if (role == studentRef) {
        final data = StudentModel(
            name: userName,
            email: email,
            imageUrl: '',
            updatedAt: DateTime.now(),
            createdAt: DateTime.now(),
            uid: uid);
        await firestore.collection(studentRef).doc(uid).set(data.toJson());
      } else {
        final data = TeacherModel(
            name: userName,
            email: email,
            imageUrl: '',
            updatedAt: DateTime.now(),
            createdAt: DateTime.now(),
            uid: uid);
        await firestore.collection(teacherRef).doc(uid).set(data.toJson());
      }
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
