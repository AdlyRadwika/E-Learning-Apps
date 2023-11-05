import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/features/data/models/assignment/assignment_model.dart';
import 'package:final_project/features/data/models/assignment/submission_model.dart';
import 'package:final_project/features/data/models/grade/grade_content_model.dart';
import 'package:final_project/features/data/models/grade/grade_model.dart';
import 'package:final_project/features/data/models/user/user_model.dart';

abstract class FirebaseGradeCloudRemote {
  Future<void> insertGrade({required GradeModel data});
  Future<void> updateGrade({
    required String gradeId,
    required int grade,
  });
  Future<GradeContentModel> getGradesByStudent({
    required String classCode,
    required String studentId,
  });
}

class FirebaseGradeCloudRemoteImpl implements FirebaseGradeCloudRemote {
  final _gradeCollection = FirebaseFirestore.instance
      .collection('assignments_grades')
      .withConverter<GradeModel>(
          fromFirestore: (snapshot, _) => GradeModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson());

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

  @override
  Future<GradeContentModel> getGradesByStudent(
      {required String classCode, required String studentId}) async {
    try {
      GradeContentModel result = GradeContentModel(
        classCode: classCode,
        id: '-',
        finalGrade: 0,
        updatedAt: '-',
        createdAt: DateTime.now().toString(),
        user: const GradeContentOwnerModel(
          uid: '-',
          name: '-',
          imageUrl: '-',
        ),
        details: [],
      );

      final assignmentQuery = await _assignmentCollection
          .where('class_code', isEqualTo: classCode)
          .get();

      if (assignmentQuery.docs.isEmpty) {
        return result;
      }

      List<GradeContentModel> gradeContentList = [];

      for (var doc in assignmentQuery.docs) {
        final assignmentData = doc.data();
        final assignmentId = assignmentData.id;

        final submissionQuery = await _submissionCollection
            .where('assignment_id', isEqualTo: assignmentId)
            .where('student_id', isEqualTo: studentId)
            .get();

        final userRef = _userCollection.doc(studentId);
        final userDoc = await userRef.get();
        final userData = userDoc.data();

        if (userData == null) {
          throw Exception('User is not the Grade owner!');
        }

        double finalGrade = 0;
        List<GradeModel> grades = [];

        if (submissionQuery.docs.isNotEmpty) {
          final assignmentDetails = <AssignmentDetailModel>[];

          for (var submissionDoc in submissionQuery.docs) {
            final submissionData = submissionDoc.data();

            assignmentDetails.add(AssignmentDetailModel(
              assignmentId: submissionData.assignmentId,
              assignmentName: assignmentData.title,
              fileUrl: submissionData.fileUrl,
              submittedDate: submissionData.createdAt,
              grade: 0,
              fileName: submissionData.fileName,
            ));
          }

          final gradeQuery = await _gradeCollection
              .where('assignment_id', isEqualTo: assignmentId)
              .where('student_id', isEqualTo: studentId)
              .get();

          for (var doc in gradeQuery.docs) {
            final gradeData = doc.data();
            grades.add(gradeData);
          }

          if (grades.isNotEmpty) {
            double calculateFinalGrade = 0;

            for (final grade in grades) {
              calculateFinalGrade += grade.grade;
            }

            finalGrade = calculateFinalGrade / gradeQuery.docs.length;

            for (var i = 0; i < assignmentDetails.length; i++) {
              assignmentDetails[i].grade = grades[i].grade;
            }

            final gradeContent = GradeContentModel(
              classCode: classCode,
              id: assignmentId,
              finalGrade: finalGrade.floor(),
              updatedAt: '-',
              createdAt: DateTime.now().toString(),
              user: GradeContentOwnerModel(
                uid: userData.uid,
                name: userData.name,
                imageUrl: userData.imageUrl,
              ),
              details: assignmentDetails,
            );

            gradeContentList.add(gradeContent);
          } else {
            final gradeContent = GradeContentModel(
              classCode: classCode,
              id: assignmentId,
              finalGrade: finalGrade.floor(),
              updatedAt: '-',
              createdAt: DateTime.now().toString(),
              user: GradeContentOwnerModel(
                uid: userData.uid,
                name: userData.name,
                imageUrl: userData.imageUrl,
              ),
              details: assignmentDetails,
            );

            gradeContentList.add(gradeContent);
          }
        }
      }

      return gradeContentList.isNotEmpty ? gradeContentList.last : result;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<void> insertGrade({required GradeModel data}) async {
    try {
      await _gradeCollection.doc(data.id).set(data);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateGrade(
      {required String gradeId, required int grade}) async {
    try {
      final result = await _gradeCollection.doc(gradeId).update({
        'grade': grade,
        'updated_at': DateTime.now().toString(),
      }).catchError((error) => throw ServerException(error.toString()));
      return result;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
