import 'package:final_project/common/services/camera_service.dart';
import 'package:final_project/common/services/face_detector_service.dart';
import 'package:final_project/common/services/ml_service.dart';
import 'package:final_project/common/services/secure_storage_service.dart';
import 'package:final_project/common/services/uuid_service.dart';
import 'package:final_project/features/data/datasources/remote/firebase_auth_remote.dart';
import 'package:final_project/features/data/datasources/remote/firebase_class_cloud_remote.dart';
import 'package:final_project/features/data/datasources/remote/firebase_user_cloud_remote.dart';
import 'package:final_project/features/data/repositories/firebase_auth_repository_impl.dart';
import 'package:final_project/features/data/repositories/firebase_class_cloud_repository_impl.dart';
import 'package:final_project/features/data/repositories/firebase_user_cloud_repository_impl.dart';
import 'package:final_project/features/domain/repositories/firebase_auth_repository.dart';
import 'package:final_project/features/domain/repositories/firebase_class_cloud_repository.dart';
import 'package:final_project/features/domain/repositories/firebase_user_cloud_repository.dart';
import 'package:final_project/features/domain/usecases/auth/login.dart';
import 'package:final_project/features/domain/usecases/auth/logout.dart';
import 'package:final_project/features/domain/usecases/auth/register.dart';
import 'package:final_project/features/domain/usecases/auth/reset_password.dart';
import 'package:final_project/features/domain/usecases/auth/update_password.dart';
import 'package:final_project/features/domain/usecases/class_cloud/create_class.dart';
import 'package:final_project/features/domain/usecases/class_cloud/get_classes_by_id.dart';
import 'package:final_project/features/domain/usecases/user_cloud/get_photo_profile_url.dart';
import 'package:final_project/features/domain/usecases/user_cloud/get_user_by_id.dart';
import 'package:final_project/features/domain/usecases/user_cloud/insert_user_data.dart';
import 'package:final_project/features/domain/usecases/user_cloud/update_photo_profile.dart';
import 'package:final_project/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/presentation/bloc/class_cloud/class_cloud_bloc.dart';
import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // Bloc
  locator.registerFactory<AuthBloc>(() => AuthBloc(
      updatePasswordUseCase: locator(),
      loginUseCase: locator(),
      registerUseCase: locator(),
      resetPasswordUseCase: locator(),
      logoutUseCase: locator()));
  locator.registerFactory<UserCloudBloc>(() => UserCloudBloc(
        updatePhotoProfileUseCase: locator(),
        getUserByIdUseCase: locator(),
        getPhotoProfileURLUseCase: locator(),
        insertUserDataUseCase: locator(),
      ));
  locator.registerFactory<ClassCloudBloc>(() => ClassCloudBloc(
        createClassUseCase: locator(),
        getClassesByIdUseCase: locator(),
      ));
  // Usecases
  locator.registerLazySingleton<LoginUseCase>(() => LoginUseCase(locator()));
  locator
      .registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(locator()));
  locator.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(locator()));
  locator.registerLazySingleton<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(locator()));
  locator.registerLazySingleton<InsertUserDataUseCase>(
      () => InsertUserDataUseCase(locator()));
  locator.registerLazySingleton<GetUserByIdUseCase>(
      () => GetUserByIdUseCase(locator()));
  locator.registerLazySingleton<GetPhotoProfileURLUseCase>(
      () => GetPhotoProfileURLUseCase(locator()));
  locator.registerLazySingleton<UpdatePhotoProfileUseCase>(
      () => UpdatePhotoProfileUseCase(locator()));
  locator.registerLazySingleton<UpdatePasswordUseCase>(
      () => UpdatePasswordUseCase(locator()));
  locator.registerLazySingleton<CreateClassUseCase>(
      () => CreateClassUseCase(locator()));
  locator.registerLazySingleton<GetClassesByIdUseCase>(
      () => GetClassesByIdUseCase(locator()));

  // Repository
  locator.registerLazySingleton<FirebaseAuthRepository>(
      () => FirebaseAuthRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<FirebaseUserCloudRepository>(
      () => FirebaseUserCloudRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<FirebaseClassCloudRepository>(
      () => FirebaseClassCloudRepositoryImpl(locator()));

  // Data source
  locator.registerLazySingleton<FirebaseAuthRemote>(
      () => FirebaseAuthRemoteImpl());
  locator.registerLazySingleton<FirebaseUserCloudRemote>(
      () => FirebaseUserCloudRemoteImpl());
  locator.registerLazySingleton<FirebaseClassCloudRemote>(
      () => FirebaseClassCloudRemoteImpl());

  // External
  locator.registerLazySingleton<CameraService>(() => CameraService());
  locator
      .registerLazySingleton<FaceDetectorService>(() => FaceDetectorService());
  locator.registerLazySingleton<MLService>(() => MLService());
  locator.registerLazySingleton(() {
    return SecureStorageInit.getService();
  });
  locator.registerLazySingleton<SecureStorageService>(
      () => SecureStorageService(storage: locator()));
  locator.registerLazySingleton(() {
    return UuidServiceInit.getService();
  });
  locator.registerLazySingleton<UuidService>(() => UuidService(locator()));
}
