import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/features/data/models/assignment/assignment_model.dart';

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
}

class FirebaseAssignmentCloudRemoteImpl
    implements FirebaseAssignmentCloudRemote {
  final _assignmentCollection = FirebaseFirestore.instance
      .collection('assignments')
      .withConverter<AssignmentModel>(
          fromFirestore: (snapshot, _) =>
              AssignmentModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson());

  @override
  Future<void> deleteAssignment({required String assignmentId}) async {
    try {
      //TODO: tambah delete submission juga
      await _assignmentCollection.doc(assignmentId).delete();
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
}
