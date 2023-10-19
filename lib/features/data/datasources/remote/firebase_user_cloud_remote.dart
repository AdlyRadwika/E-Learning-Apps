import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/common/error/exception.dart';
import 'package:final_project/features/data/models/user/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebaseUserCloudRemote {
  Future<void> insertUserData(
      {required String uid,
      required String email,
      required String userName,
      required List imageData,
      String imageUrl = '',
      required String role});
  Future<UserModel> getUserById({
    required String uid,
  });
  Future<String> getPhotoProfileUrl({
    required File file,
  });
  Future<void> updatePhotoProfile(
      {required String imageUrl, required String uid, required List imageData});
}

class FirebaseUserCloudRemoteImpl implements FirebaseUserCloudRemote {
  final _userCollection = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson());

  final _imageStorage = FirebaseStorage.instance.ref('images');

  @override
  Future<void> insertUserData(
      {required String uid,
      required String email,
      required String userName,
      required List imageData,
      String imageUrl = '',
      required String role}) async {
    try {
      final data = UserModel(
          name: userName,
          email: email,
          imageUrl: imageUrl,
          imageData: imageData,
          role: role,
          updatedAt: '',
          createdAt: DateTime.now().toString(),
          uid: uid);
      await _userCollection.doc(uid).set(data);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserModel> getUserById({
    required String uid,
  }) async {
    try {
      final result = await _userCollection.doc(uid).get();
      return result.data() as UserModel;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> getPhotoProfileUrl({required File file}) async {
    try {
      final uploadTask = await _imageStorage
          .child(file.path.hashCode.toString())
          .putFile(file)
          .whenComplete(() {});
      final result = uploadTask.ref.getDownloadURL();
      return result;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updatePhotoProfile(
      {required String imageUrl,
      required String uid,
      required List imageData}) async {
    try {
      final result = await _userCollection.doc(uid).update({
        'image_url': imageUrl,
        'image_data': imageData,
      }).catchError((error) => throw ServerException(error.toString()));
      return result;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Exception");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
