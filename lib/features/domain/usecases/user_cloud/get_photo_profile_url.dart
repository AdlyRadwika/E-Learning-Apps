import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:final_project/common/error/failure.dart';
import 'package:final_project/features/domain/repositories/firebase_user_cloud_repository.dart';

class GetPhotoProfileURLUseCase {
  final FirebaseUserCloudRepository repository;

  const GetPhotoProfileURLUseCase(this.repository);

  Future<Either<Failure, String>> execute({
    required File file,
  }) {
    return repository.getPhotoProfileUrl(
      file: file,
    );
  }
}
