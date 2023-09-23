import 'package:final_project/common/services/camera_service.dart';
import 'package:final_project/common/services/face_detector_service.dart';
import 'package:final_project/common/services/ml_service.dart';
import 'package:final_project/features/data/datasources/remote/firebase_auth_remote.dart';
import 'package:final_project/features/data/datasources/remote/firebase_user_store_remote.dart';
import 'package:final_project/features/data/repositories/firebase_auth_repository_impl.dart';
import 'package:final_project/features/data/repositories/firebase_user_store_repository_impl.dart';
import 'package:final_project/features/domain/repositories/firebase_auth_repository.dart';
import 'package:final_project/features/domain/repositories/firebase_user_store_repository.dart';
import 'package:final_project/features/domain/usecases/auth/login.dart';
import 'package:final_project/features/domain/usecases/auth/logout.dart';
import 'package:final_project/features/domain/usecases/auth/register.dart';
import 'package:final_project/features/domain/usecases/user_store/insert_user_data.dart';
import 'package:final_project/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/presentation/bloc/user_store/user_store_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // Bloc
  locator.registerFactory<AuthBloc>(() => AuthBloc(
      loginUseCase: locator(),
      registerUseCase: locator(),
      logoutUseCase: locator()));
  locator.registerFactory<UserStoreBloc>(() => UserStoreBloc(
        insertUserDataUseCase: locator(),
      ));
  // Usecases
  locator.registerLazySingleton<LoginUseCase>(() => LoginUseCase(locator()));
  locator
      .registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(locator()));
  locator.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(locator()));
  locator.registerLazySingleton<InsertUserDataUseCase>(
      () => InsertUserDataUseCase(locator()));

  // Repository
  locator.registerLazySingleton<FirebaseAuthRepository>(
      () => FirebaseAuthRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<FirebaseUserStoreRepository>(
      () => FirebaseUserStoreRepositoryImpl(remoteDataSource: locator()));

  // Data source
  locator.registerLazySingleton<FirebaseAuthRemote>(
      () => FirebaseAuthRemoteImpl());
  locator.registerLazySingleton<FirebaseUserStoreRemote>(
      () => FirebaseUserStoreRemoteImpl());

  // External
  locator.registerLazySingleton<CameraService>(() => CameraService());
  locator.registerLazySingleton<FaceDetectorService>(() => FaceDetectorService());
  locator.registerLazySingleton<MLService>(() => MLService());
}
