import 'package:final_project/features/data/datasources/remote/firebase_auth_remote.dart';
import 'package:final_project/features/data/repositories/firebase_auth_repository_impl.dart';
import 'package:final_project/features/domain/repositories/firebase_auth_repository.dart';
import 'package:final_project/features/domain/usecases/auth/login.dart';
import 'package:final_project/features/domain/usecases/auth/logout.dart';
import 'package:final_project/features/domain/usecases/auth/register.dart';
import 'package:final_project/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // Bloc
  locator.registerFactory<AuthBloc>(() => AuthBloc(
      loginUseCase: locator(),
      registerUseCase: locator(),
      logoutUseCase: locator()));
  // Usecases
  locator.registerLazySingleton<LoginUseCase>(() => LoginUseCase(locator()));
  locator
      .registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(locator()));
  locator.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(locator()));

  // Repository
  locator.registerLazySingleton<FirebaseAuthRepository>(
      () => FirebaseAuthRepositoryImpl(remoteDataSource: locator()));

  // Data source
  locator.registerLazySingleton<FirebaseAuthRemoteData>(
      () => FirebaseAuthRemoteDataImpl());

  // External
}
