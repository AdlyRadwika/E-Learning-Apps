import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/entities/user/user.dart';

abstract class FirebaseUserCloudRepository {
  Future<Either<Failure, void>> insertUserData(
      {required String uid,
      required String email,
      required String userName,
      required List imageData,
      String imageUrl = '',
      required String role});
  Future<Either<Failure, User>> getUserById({
    required String uid,
  });
}
