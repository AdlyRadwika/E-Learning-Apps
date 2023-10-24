import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/features/data/models/attendance/attendance_content_model.dart';
import 'package:final_project/features/data/models/attendance/attendance_model.dart';
import 'package:final_project/features/data/models/user/user_model.dart';

abstract class FirebaseAttendanceCloudRemote {
  Future<void> insertAttendance({
    required AttendanceModel data,
  });
  Future<List<AttendanceContentModel>> getAttendancesByClass({
    required String classCode,
  });
}

class FirebaseAttendanceCloudRemoteImpl
    implements FirebaseAttendanceCloudRemote {
  final _attendanceCollection = FirebaseFirestore.instance
      .collection('attendances')
      .withConverter<AttendanceModel>(
          fromFirestore: (snapshot, _) =>
              AttendanceModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson());
  final _userCollection = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson());

  @override
  Future<List<AttendanceContentModel>> getAttendancesByClass(
      {required String classCode}) async {
    try {
      return FirebaseFirestore.instance.runTransaction((transaction) async {
        final querySnapshot = await _attendanceCollection
            .where('class_code', isEqualTo: classCode)
            .get();

        List<AttendanceModel> attendances = [];
        for (var doc in querySnapshot.docs) {
          final data = doc.data();

          attendances.add(data);
        }

        List<AttendanceContentModel> result = [];
        for (var attendance in attendances) {
          final userRef = _userCollection.doc(attendance.studentId);
          final userDoc = await transaction.get(userRef);
          final userData = userDoc.data();

          if (userData == null) {
            throw Exception('User is not the Attendance owner!');
          }

          final data = AttendanceContentModel(
              id: attendance.id,
              label: attendance.label,
              studentId: userData.uid,
              studentImageUrl: userData.imageUrl,
              studentName: userData.name,
              attendanceDate: attendance.createdAt);

          result.add(data);
        }

        return result
          ..sort(
            (a, b) => DateTime.parse(b.attendanceDate)
                .compareTo(DateTime.parse(a.attendanceDate)),
          );
      });
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> insertAttendance({required AttendanceModel data}) async {
    try {
      await _attendanceCollection.doc(data.id).set(data);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
