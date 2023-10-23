// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:final_project/common/error/exception.dart';
// import 'package:final_project/features/data/models/Attendance/Attendance_content_model.dart';
// import 'package:final_project/features/data/models/Attendance/Attendance_model.dart';
// import 'package:final_project/features/data/models/user/user_model.dart';

// abstract class FirebaseAttendanceCloudRemote {
//   Future<void> insertAttendance({
//     required String attendanceId,
//     required String studentId,
//     required String classCode,
//   });
//   Future<List<AttendanceContentModel>> getAttendancesByClass({
//     required String classCode,
//   });
// }

// class FirebaseAttendanceCloudRemoteImpl
//     implements FirebaseAttendanceCloudRemote {
//   final _attendanceCollection = FirebaseFirestore.instance
//       .collection('attendances')
//       .withConverter<AttendanceModel>(
//           fromFirestore: (snapshot, _) =>
//               AttendanceModel.fromJson(snapshot.data()!),
//           toFirestore: (value, _) => value.toJson());
//   final _userCollection = FirebaseFirestore.instance
//       .collection('users')
//       .withConverter<UserModel>(
//           fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
//           toFirestore: (value, _) => value.toJson());

//   @override
//   Future<List<AttendanceContentModel>> getAttendancesByClass(
//       {required String classCode}) async {
//     try {
//       return FirebaseFirestore.instance.runTransaction((transaction) async {
//         // final querySnapshot = await _AttendanceCollection
//         //     .where('class_code', isEqualTo: classCode)
//         //     .get();

//         // List<AttendanceModel> Attendances = [];
//         // for (var doc in querySnapshot.docs) {
//         //   final AttendanceData = doc.data();

//         //   Attendances.add(AttendanceData);
//         // }

//         // List<AttendanceContentModel> result = [];
//         // for (var Attendance in Attendances) {
//         //   final userRef = _userCollection.doc(Attendance.teacherId);
//         //   final userDoc = await transaction.get(userRef);
//         //   final userData = userDoc.data();

//         //   if (userData == null) {
//         //     throw Exception('User is not the Attendance owner!');
//         //   }

//         //   final data = AttendanceContentModel(
//         //       id: Attendance.id,
//         //       content: Attendance.content,
//         //       updatedAt: Attendance.updatedAt,
//         //       createdAt: Attendance.createdAt,
//         //       owner: AttendanceOwnerModel(
//         //           uid: Attendance.teacherId,
//         //           name: userData.name,
//         //           imageUrl: userData.imageUrl),
//         //       classCode: Attendance.classCode);

//         //   result.add(data);
//         // }

//         // return result
//         //   ..sort(
//         //     (a, b) => DateTime.parse(b.createdAt)
//         //         .compareTo(DateTime.parse(a.createdAt)),
//         //   );
//       });
//     } on FirebaseException catch (e) {
//       throw ServerException(e.message ?? "Unknown Firebase Exception");
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   @override
//   Future<void> insertAttendance(
//       {required String attendanceId,
//       required String classCode}) async {
//     try {
//       final data = AttendanceModel(
//           id: AttendanceId,
//           content: content,
//           teacherId: teacherId,
//           updatedAt: "",
//           createdAt: DateTime.now().toString(),
//           classCode: classCode);
//       await _attendanceCollection.doc(attendanceId).set(data);
//     } on FirebaseException catch (e) {
//       throw ServerException(e.message ?? "Unknown Firebase Exception");
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
// }
