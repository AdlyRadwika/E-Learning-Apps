import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/features/data/models/class/class_model.dart';
import 'package:final_project/features/data/models/class/enrolled_class_model.dart';
import 'package:flutter/foundation.dart';

abstract class FirebaseClassCloudRemote {
  Future<void> createClass({
    required String code,
    required String title,
    required String description,
    required String teacherId,
  });
  Future<List<ClassModel>> getClassesByUid({required String userId});
  Future<void> joinClass({required String code, required String uid});
  Future<List<EnrolledClassModel>> getEnrolledClassesByUid({
    required String userId,
  });
}

class FirebaseClassCloudRemoteImpl implements FirebaseClassCloudRemote {
  final _classesCollection = FirebaseFirestore.instance
      .collection('classes')
      .withConverter<ClassModel>(
          fromFirestore: (snapshot, _) => ClassModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson());
  final _enrolledClassCollection = FirebaseFirestore.instance
      .collection('enrolled_classes')
      .withConverter<EnrolledClassModel>(
          fromFirestore: (snapshot, _) =>
              EnrolledClassModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson());

  @override
  Future<void> createClass(
      {required String code,
      required String title,
      required String description,
      required String teacherId}) async {
    try {
      return FirebaseFirestore.instance.runTransaction((transaction) async {
        final data = ClassModel(
            title: title,
            description: description,
            teacherId: teacherId,
            updatedAt: DateTime.now().toIso8601String(),
            createdAt: DateTime.now().toIso8601String(),
            code: code);
        final existingClassList = await _classesCollection
            .where(
              'title',
              isEqualTo: title,
            )
            .get();
        final existingClass = existingClassList.docs.first.data();
        if (existingClass.title == title) {
          throw Exception("There is already a class with the same title!");
        }
        await _classesCollection.doc(code).set(data);
      }).catchError((error) => throw ServerException(error.toString()));
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

  @override
  Future<List<EnrolledClassModel>> getEnrolledClassesByUid(
      {required String userId}) async {
    try {
      final querySnapshot = await _enrolledClassCollection
          .where(
            'student_id',
            isEqualTo: userId,
          )
          .get();
      List<EnrolledClassModel> result = [];
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

  @override
  Future<void> joinClass({required String code, required String uid}) async {
    try {
      return FirebaseFirestore.instance.runTransaction((transaction) async {
        final classDoc = await _classesCollection.doc(code).get();
        final classData = classDoc.data();
        if (classData == null) {
          throw Exception("The class is not exist!");
        }
        final data = EnrolledClassModel(
          title: classData.title,
          description: classData.description,
          code: code,
          studentId: uid,
          updatedAt: '',
          createdAt: DateTime.now().toIso8601String(),
        );
        final existingClassList = await _enrolledClassCollection
            .where(
              'student_id',
              isEqualTo: uid,
            )
            .where('code', isEqualTo: code)
            .get();
        final existingClass = existingClassList.docs.first.data();
        if (existingClass.code == code) {
          throw Exception("You have joined this class!");
        }
        await _enrolledClassCollection.doc().set(data);
      }).catchError((error) => throw ServerException(error.toString()));
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e, stacktrace) {
      debugPrint(stacktrace.toString());
      throw Exception(e.toString());
    }
  }
}
