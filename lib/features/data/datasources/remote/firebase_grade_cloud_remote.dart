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
      return FirebaseFirestore.instance.runTransaction((transaction) async {
        final assignmentQuery = await _assignmentCollection
            .where('class_code', isEqualTo: classCode)
            .get();

        GradeContentModel? result;
        List<AssignmentModel> assignments = [];
        List<AssignmentDetailModel> assignmentDetails = [];
        for (var doc in assignmentQuery.docs) {
          final assignmentData = doc.data();

          //FIXME: something went wrong here
          assignments.add(assignmentData);

          final submissionQuery = await _submissionCollection
              .where(
                'assignment_id',
                isEqualTo: assignmentData.id,
              )
              .where(
                'student_id',
                isEqualTo: studentId,
              )
              .get();
          for (var submissionDoc in submissionQuery.docs) {
            final submissionData = submissionDoc.data();

            final data = AssignmentDetailModel(
                assignmentId: submissionData.assignmentId,
                assignmentName: assignmentData.title,
                fileUrl: submissionData.fileUrl,
                submittedDate: submissionData.createdAt,
                grade: 0,
                fileName: submissionData.fileName);

            assignmentDetails.add(data);
          }

          final gradeQuery = await _gradeCollection
              .where('assignment_id', isEqualTo: assignmentData.id)
              .get();
          List<GradeModel> grades = [];
          int calculateFinalGrade = 0;
          for (var doc in gradeQuery.docs) {
            final gradeData = doc.data();

            grades.add(gradeData);
            final grade = gradeData.grade;
            if (grade == 0) {
              calculateFinalGrade *= 0;
            } else {
              calculateFinalGrade += gradeData.grade;
            }
          }

          final finalGrade =
              grades.isNotEmpty ? calculateFinalGrade / grades.length : 0;

          for (var grade in grades) {
            final userRef = _userCollection.doc(grade.studentId);
            final userDoc = await transaction.get(userRef);
            final userData = userDoc.data();

            if (userData == null) {
              throw Exception('User is not the Grade owner!');
            }

            print(classCode);
            print(studentId);

            result = GradeContentModel(
              classCode: classCode,
              id: grade.id,
              finalGrade: finalGrade.floor(),
              updatedAt: grade.updatedAt,
              createdAt: grade.createdAt,
              user: GradeContentOwnerModel(
                  uid: userData.uid,
                  name: userData.name,
                  imageUrl: userData.imageUrl),
              details: assignmentDetails.map((data) {
                final assignmentGrade =
                    data.assignmentId == grade.assignmentId ? grade.grade : 0;
                return AssignmentDetailModel(
                    assignmentId: data.assignmentId,
                    assignmentName: data.assignmentName,
                    fileUrl: data.fileUrl,
                    grade: assignmentGrade,
                    submittedDate: data.submittedDate,
                    fileName: data.fileName);
              }).toList(),
            );

            print("result.id");
            print(result.id);
            print(result.finalGrade);
          }
        }

        if (result != null) {
          return result;
        } else {
          throw Exception('Grade is empty!');
        }
      });
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
