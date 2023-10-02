import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';

abstract class FirebaseUserStoreRepository {
  Future<Either<Failure, void>> insertUserData(
      {required String uid,
      required String email,
      required String userName,
      required List imageData,
      String imageUrl = '',
      required String role});
}
