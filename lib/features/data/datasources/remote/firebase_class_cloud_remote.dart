import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/features/data/models/class/class_model.dart';
import 'package:final_project/features/data/models/class/class_user_model.dart';
import 'package:final_project/features/data/models/class/enrolled_class_model.dart';
import 'package:final_project/features/data/models/user/user_model.dart';
import 'package:flutter/foundation.dart';

abstract class FirebaseClassCloudRemote {
  Future<void> createClass({
    required String code,
    required String title,
    required String description,
    required String teacherId,
  });
  Future<Stream<QuerySnapshot<ClassModel>>> getClassesByUid(
      {required String userId});
  Future<void> joinClass({required String code, required String uid});
  Future<Stream<QuerySnapshot<EnrolledClassModel>>> getEnrolledClassesByUid({
    required String userId,
  });
  Future<ClassUserModel> getClassTeacher({
    required String classCode,
  });
  Future<List<ClassUserModel>> getClassStudents({
    required String classCode,
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
  final _userCollection = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
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
            updatedAt: '',
            createdAt: DateTime.now().toString(),
            code: code);

        final existingClassList = await _classesCollection
            .where(
              'title',
              isEqualTo: title,
            )
            .get();
        if (existingClassList.docs.isNotEmpty) {
          final existingClass = existingClassList.docs.first.data();
          if (existingClass.title == title) {
            throw Exception("There is already a class with the same title!");
          }
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
  Future<Stream<QuerySnapshot<ClassModel>>> getClassesByUid(
      {required String userId}) async {
    try {
      final streamQuerySnapshot =
          _classesCollection.where('teacher_id', isEqualTo: userId).snapshots();
      return streamQuerySnapshot;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Stream<QuerySnapshot<EnrolledClassModel>>> getEnrolledClassesByUid(
      {required String userId}) async {
    try {
      final streamQuerySnapshot = _enrolledClassCollection
          .where(
            'student_id',
            isEqualTo: userId,
          )
          .snapshots();
      return streamQuerySnapshot;
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
          createdAt: DateTime.now().toString(),
        );

        final existingClassList = await _enrolledClassCollection
            .where(
              'student_id',
              isEqualTo: uid,
            )
            .where('code', isEqualTo: code)
            .get();
        if (existingClassList.docs.isNotEmpty) {
          final existingClass = existingClassList.docs.first.data();
          if (existingClass.code == code) {
            throw Exception("You have joined this class!");
          }
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

  @override
  Future<ClassUserModel> getClassTeacher({required String classCode}) async {
    try {
      return FirebaseFirestore.instance.runTransaction((transaction) async {
        final classRef = _classesCollection.doc(classCode);
        final classDoc = await transaction.get(classRef);
        final classData = classDoc.data();

        if (classData == null) {
          throw Exception('The class is not exist!');
        }

        final userRef = _userCollection.doc(classData.teacherId);
        final userDoc = await transaction.get(userRef);
        final userData = userDoc.data();

        if (userData == null) {
          throw Exception('The teacher is not exist!');
        }

        final result = ClassUserModel(
            name: userData.name,
            imageUrl: userData.imageUrl,
            role: userData.role,
            joinedAt: classData.createdAt,
            uid: userData.uid);

        return result;
      });
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<ClassUserModel>> getClassStudents({required String classCode}) {
    try {
      return FirebaseFirestore.instance.runTransaction((transaction) async {
        final querySnapshot = await _enrolledClassCollection
            .where('code', isEqualTo: classCode)
            .get();

        List<EnrolledClassModel> enrolledClasses = [];
        for (var docSnaphot in querySnapshot.docs) {
          final data = docSnaphot.data();
          enrolledClasses.add(data);
        }

        List<ClassUserModel> result = [];
        for (var enrolled in enrolledClasses) {
          final userRef = _userCollection.doc(enrolled.studentId);
          final userDoc = await transaction.get(userRef);
          final userData = userDoc.data();

          if (userData == null) {
            throw Exception('User is not enrolled in the class!');
          }

          final data = ClassUserModel(
              name: userData.name,
              imageUrl: userData.imageUrl,
              role: userData.role,
              joinedAt: enrolled.createdAt,
              uid: userData.uid);
          result.add(data);
        }

        return result;
      });
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
