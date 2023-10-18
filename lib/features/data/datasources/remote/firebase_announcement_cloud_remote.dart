import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/features/data/models/announcement/announcement_model.dart';

abstract class FirebaseAnnouncementCloudRemote {
  Future<void> insertAnnouncement({
    required String announcementId,
    required String teacherId,
    required String content,
    required String classCode,
  });
  Future<void> updateAnnouncement({
    required String announcementId,
    required String content,
  });
  Future<void> deleteAnnouncement({
    required String announcementId,
  });
  Future<List<AnnouncementModel>> getAnnouncementsByUid({
    required String uid,
  });
}

class FirebaseAnnouncementCloudRemoteImpl
    implements FirebaseAnnouncementCloudRemote {
  final _announcementCollection = FirebaseFirestore.instance
      .collection('announcements')
      .withConverter<AnnouncementModel>(
          fromFirestore: (snapshot, _) =>
              AnnouncementModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson());

  @override
  Future<List<AnnouncementModel>> getAnnouncementsByUid(
      {required String uid}) async {
    try {
      final querySnapshot = await _announcementCollection
          .where('teacher_id', isEqualTo: uid)
          .get();

      List<AnnouncementModel> result = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
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
  Future<void> insertAnnouncement(
      {required String announcementId,
      required String teacherId,
      required String content,
      required String classCode}) async {
    try {
      final data = AnnouncementModel(
          id: announcementId,
          content: content,
          teacherId: teacherId,
          updatedAt: "",
          createdAt: DateTime.now().toIso8601String(),
          classCode: classCode);
      await _announcementCollection.doc(announcementId).set(data);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateAnnouncement(
      {required String announcementId, required String content}) async {
    try {
      final result = await _announcementCollection.doc(announcementId).update({
        'content': content,
      }).catchError((error) => throw ServerException(error.toString()));
      return result;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteAnnouncement({required String announcementId}) async {
    try {
      await _announcementCollection.doc(announcementId).delete();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
