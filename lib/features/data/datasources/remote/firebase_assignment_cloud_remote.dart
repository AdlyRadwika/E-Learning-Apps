import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/common/extensions/file.dart';
import 'package:final_project/features/data/models/assignment/assignment_model.dart';
import 'package:final_project/features/data/models/assignment/students_assignment_status_model.dart';
import 'package:final_project/features/data/models/assignment/submission_model.dart';
import 'package:final_project/features/data/models/class/enrolled_class_model.dart';
import 'package:final_project/features/data/models/user/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebaseAssignmentCloudRemote {
  Future<void> insertAssignment({
    required AssignmentModel data,
  });
  Future<void> updateAssignment({
    required AssignmentModel data,
  });
  Future<void> deleteAssignment({
    required String assignmentId,
  });
  Future<Stream<QuerySnapshot<AssignmentModel>>> getAssignmentsByClass({
    required String classCode,
  });
  Future<SubmissionModel> getSubmissionFile(
      {required File file,
      required String studentId,
      required String assignmentId});
  Future<void> uploadSubmission({required SubmissionModel data});
  Future<Stream<QuerySnapshot<SubmissionModel>>> getSubmissionStatus(
      {required String assignmentId, required String studentId});
  Future<List<StudentsAssignmentStatusModel>> getSubmittedAssignments({
    required String assignmentId,
  });
  Future<List<StudentsAssignmentStatusModel>> getUnsubmittedAssignments({
    required String assignmentId,
  });
}

class FirebaseAssignmentCloudRemoteImpl
    implements FirebaseAssignmentCloudRemote {
  final _assignmentCollection = FirebaseFirestore.instance
      .collection('assignments')
      .withConverter<AssignmentModel>(
          fromFirestore: (snapshot, _) =>
              AssignmentModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson());

  final _submissionCollection = FirebaseFirestore.instance
      .collection('assignment_submissions')
      .withConverter<SubmissionModel>(
          fromFirestore: (snapshot, _) =>
              SubmissionModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson());

  final _userCollection = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson());

  final _enrolledCollection = FirebaseFirestore.instance
      .collection('enrolled_classes')
      .withConverter<EnrolledClassModel>(
          fromFirestore: (snapshot, _) =>
              EnrolledClassModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson());

  final _fileStorage = FirebaseStorage.instance.ref('files');

  @override
  Future<void> deleteAssignment({required String assignmentId}) async {
    try {
      final batch = FirebaseFirestore.instance.batch();

      await _assignmentCollection.doc(assignmentId).delete();

      await _submissionCollection
          .where('assignment_id', isEqualTo: assignmentId)
          .get()
          .then((querySnapshot) {
        for (var document in querySnapshot.docs) {
          batch.delete(document.reference);
        }
      });

      return batch.commit();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Stream<QuerySnapshot<AssignmentModel>>> getAssignmentsByClass(
      {required String classCode}) async {
    try {
      final streamQuerySnapshot = _assignmentCollection
          .where('class_code', isEqualTo: classCode)
          .snapshots();
      return streamQuerySnapshot;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> insertAssignment({required AssignmentModel data}) async {
    try {
      await _assignmentCollection.doc(data.id).set(data);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateAssignment({
    required AssignmentModel data,
  }) async {
    try {
      await _assignmentCollection.doc(data.id).update({
        'title': data.title,
        'description': data.description,
        'deadline': data.deadline,
      }).catchError((error) => throw ServerException(error.toString()));
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<SubmissionModel> getSubmissionFile(
      {required File file,
      required String studentId,
      required String assignmentId}) async {
    try {
      final fileName = file.name;
      final uploadTask = await _fileStorage
          .child("$fileName-${file.hashCode}")
          .putFile(file)
          .whenComplete(() {});
      final fileUrl = await uploadTask.ref.getDownloadURL();

      final data = SubmissionModel(
          id: file.hashCode.toString(),
          fileUrl: fileUrl,
          fileName: fileName,
          studentId: studentId,
          updatedAt: "-",
          createdAt: DateTime.now().toString(),
          assignmentId: assignmentId);

      return data;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> uploadSubmission({required SubmissionModel data}) async {
    try {
      await _submissionCollection.doc(data.id).set(data);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Stream<QuerySnapshot<SubmissionModel>>> getSubmissionStatus(
      {required String assignmentId, required String studentId}) async {
    try {
      final streamQuerySnapshot = _submissionCollection
          .where('assignment_id', isEqualTo: assignmentId)
          .where('student_id', isEqualTo: studentId)
          .snapshots();
      return streamQuerySnapshot;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<StudentsAssignmentStatusModel>> getSubmittedAssignments(
      {required String assignmentId}) {
    try {
      return FirebaseFirestore.instance.runTransaction((transaction) async {
        final assignmentQuery =
            await _assignmentCollection.doc(assignmentId).get();
        final assignmentData = assignmentQuery.data();

        final submissionQuery = await _submissionCollection
            .where(
              'assignment_id',
              isEqualTo: assignmentData?.id ?? "-",
            )
            .get();

        List<StudentsAssignmentStatusModel> result = [];
        for (var doc in submissionQuery.docs) {
          final docData = doc.data();
          final userRef = _userCollection.doc(docData.studentId);
          final userDoc = await transaction.get(userRef);
          final userData = userDoc.data();

          if (userData == null) {
            throw Exception('User is not exist!');
          }

          final data = StudentsAssignmentStatusModel(
              studentName: userData.name,
              fileUrl: docData.fileUrl,
              submittedDate: docData.createdAt);
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

  @override
  Future<List<StudentsAssignmentStatusModel>> getUnsubmittedAssignments(
      {required String assignmentId}) {
    try {
      return FirebaseFirestore.instance.runTransaction((transaction) async {
        final assignmentQuery =
            await _assignmentCollection.doc(assignmentId).get();
        final assignmentData = assignmentQuery.data();

        final submissionQuery = await _submissionCollection
            .where(
              'assignment_id',
              isEqualTo: assignmentData?.id ?? "-",
            )
            .get();

        QuerySnapshot<EnrolledClassModel>? enrolledQuery;

        final submissionDocs = submissionQuery.docs;

        List<StudentsAssignmentStatusModel> result = [];
        if (submissionDocs.isNotEmpty) {
          enrolledQuery = await _enrolledCollection
              .where('code', isEqualTo: assignmentData?.classCode ?? "-")
              .endBeforeDocument(submissionDocs.last)
              .get();
        } else {
          enrolledQuery = await _enrolledCollection
              .where('code', isEqualTo: assignmentData?.classCode ?? "-")
              .get();
        }

        for (var enrolled in enrolledQuery.docs) {
          final enrolledData = enrolled.data();
          final userRef = _userCollection.doc(enrolledData.studentId);
          final userDoc = await transaction.get(userRef);
          final userData = userDoc.data();

          if (userData == null) {
            throw Exception('User is not exist!');
          }

          final data = StudentsAssignmentStatusModel(
              studentName: userData.name, fileUrl: '-', submittedDate: "-");
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
