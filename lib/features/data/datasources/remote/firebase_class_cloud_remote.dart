import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/features/data/models/class/class_model.dart';

abstract class FirebaseClassCloudRemote {
  Future<void> createClass({
    required String code,
    required String title,
    required String description,
    required String teacherId,
  });
  Future<List<ClassModel>> getClassesByUid({required String userId});
}

class FirebaseClassCloudRemoteImpl implements FirebaseClassCloudRemote {
  final _classesCollection = FirebaseFirestore.instance
      .collection('classes')
      .withConverter<ClassModel>(
          fromFirestore: (snapshot, _) => ClassModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson());

  @override
  Future<void> createClass(
      {required String code,
      required String title,
      required String description,
      required String teacherId}) async {
    try {
      final data = ClassModel(
          title: title,
          description: description,
          teacherId: teacherId,
          updatedAt: DateTime.now().toIso8601String(),
          createdAt: DateTime.now().toIso8601String(),
          code: code);
      await _classesCollection.doc(code).set(data);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<ClassModel>> getClassesByUid({required String userId}) async {
    try {
      final querySnapshot =
          await _classesCollection.where('teacher_id', isEqualTo: userId).get();
      List<ClassModel> result = [];
      for (var docSnapshot in querySnapshot.docs) {
        final data = docSnapshot.data();
        result.add(data);
      }
      return result;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
