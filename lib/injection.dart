import 'package:final_project/common/services/camera_service.dart';
import 'package:final_project/common/services/face_detector_service.dart';
import 'package:final_project/common/services/ml_service.dart';
import 'package:final_project/common/services/secure_storage_service.dart';
import 'package:final_project/common/services/uuid_service.dart';
import 'package:final_project/common/util/switch_theme_util.dart';
import 'package:final_project/features/data/datasources/remote/firebase_announcement_cloud_remote.dart';
import 'package:final_project/features/data/datasources/remote/firebase_assignment_cloud_remote.dart';
import 'package:final_project/features/data/datasources/remote/firebase_attendance_cloud_remote.dart';
import 'package:final_project/features/data/datasources/remote/firebase_auth_remote.dart';
import 'package:final_project/features/data/datasources/remote/firebase_class_cloud_remote.dart';
import 'package:final_project/features/data/datasources/remote/firebase_user_cloud_remote.dart';
import 'package:final_project/features/data/repositories/firebase_announcement_cloud_repository_impl.dart';
import 'package:final_project/features/data/repositories/firebase_assignment_cloud_repository_impl.dart';
import 'package:final_project/features/data/repositories/firebase_attendance_cloud_repository_impl.dart';
import 'package:final_project/features/data/repositories/firebase_auth_repository_impl.dart';
import 'package:final_project/features/data/repositories/firebase_class_cloud_repository_impl.dart';
import 'package:final_project/features/data/repositories/firebase_user_cloud_repository_impl.dart';
import 'package:final_project/features/domain/repositories/firebase_announcement_cloud_repository.dart';
import 'package:final_project/features/domain/repositories/firebase_assignment_cloud_repository.dart';
import 'package:final_project/features/domain/repositories/firebase_attendance_cloud_repository.dart';
import 'package:final_project/features/domain/repositories/firebase_auth_repository.dart';
import 'package:final_project/features/domain/repositories/firebase_class_cloud_repository.dart';
import 'package:final_project/features/domain/repositories/firebase_user_cloud_repository.dart';
import 'package:final_project/features/domain/usecases/announcement_cloud/delete_announcement.dart';
import 'package:final_project/features/domain/usecases/announcement_cloud/get_announcements_by_class.dart';
import 'package:final_project/features/domain/usecases/announcement_cloud/insert_announcement.dart';
import 'package:final_project/features/domain/usecases/announcement_cloud/update_announcement.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/delete_assignment.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/get_assignments_by_class.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/get_submission_file.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/get_submission_status.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/get_submitted_assignments.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/get_unsubmitted_assignments.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/insert_assignment.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/update_assignment.dart';
import 'package:final_project/features/domain/usecases/assignment_cloud/upload_submission.dart';
import 'package:final_project/features/domain/usecases/attendance_cloud/get_attendance_by_class.dart';
import 'package:final_project/features/domain/usecases/attendance_cloud/insert_attendance.dart';
import 'package:final_project/features/domain/usecases/auth/login.dart';
import 'package:final_project/features/domain/usecases/auth/logout.dart';
import 'package:final_project/features/domain/usecases/auth/register.dart';
import 'package:final_project/features/domain/usecases/auth/reset_password.dart';
import 'package:final_project/features/domain/usecases/auth/update_password.dart';
import 'package:final_project/features/domain/usecases/class_cloud/create_class.dart';
import 'package:final_project/features/domain/usecases/class_cloud/get_class_students.dart';
import 'package:final_project/features/domain/usecases/class_cloud/get_class_teacher.dart';
import 'package:final_project/features/domain/usecases/class_cloud/get_classes_by_id.dart';
import 'package:final_project/features/domain/usecases/class_cloud/get_enrolled_classes_by_id.dart';
import 'package:final_project/features/domain/usecases/class_cloud/join_class.dart';
import 'package:final_project/features/domain/usecases/user_cloud/get_photo_profile_url.dart';
import 'package:final_project/features/domain/usecases/user_cloud/get_user_by_id.dart';
import 'package:final_project/features/domain/usecases/user_cloud/insert_user_data.dart';
import 'package:final_project/features/domain/usecases/user_cloud/update_photo_profile.dart';
import 'package:final_project/features/presentation/bloc/announcement_cloud/announcement_cloud_bloc.dart';
import 'package:final_project/features/presentation/bloc/announcement_cloud/get_announcement/get_announcements_bloc.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/assignment_cloud_bloc.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/get_assignment/get_assignment_bloc.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/get_submission_status/get_submission_bloc.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/get_submitted_assignments/get_submitted_assignment_bloc.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/get_unsubmitted_assignments/get_unsubmitted_assignment_bloc.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/upload_submission/upload_submission_bloc.dart';
import 'package:final_project/features/presentation/bloc/attendance_cloud/attendance_cloud_bloc.dart';
import 'package:final_project/features/presentation/bloc/attendance_cloud/get_attendance/get_attendance_bloc.dart';
import 'package:final_project/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/presentation/bloc/class_cloud/class_cloud_bloc.dart';
import 'package:final_project/features/presentation/bloc/class_cloud/class_index/class_index_bloc.dart';
import 'package:final_project/features/presentation/bloc/class_cloud/get_class_students/get_class_students_bloc.dart';
import 'package:final_project/features/presentation/bloc/class_cloud/get_class_teacher/get_class_teacher_bloc.dart';
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
        joinClassUseCase: locator(),
        createClassUseCase: locator(),
      ));
  locator.registerFactory<ClassIndexBloc>(() => ClassIndexBloc(
        getEnrolledClassesByIdUseCase: locator(),
        getClassesByIdUseCase: locator(),
      ));
  locator.registerFactory<GetClassTeacherBloc>(() => GetClassTeacherBloc(
        getClassTeacherUseCase: locator(),
      ));
  locator.registerFactory<GetClassStudentsBloc>(() => GetClassStudentsBloc(
        getClassStudentsUseCase: locator(),
      ));
  locator.registerFactory<AnnouncementCloudBloc>(() => AnnouncementCloudBloc(
        deleteUseCase: locator(),
        insertUseCase: locator(),
        updateUseCase: locator(),
      ));
  locator.registerFactory<GetAnnouncementsBloc>(() => GetAnnouncementsBloc(
        getAnnouncementsUseCase: locator(),
      ));
  locator.registerFactory<AssignmentCloudBloc>(() => AssignmentCloudBloc(
        deleteUseCase: locator(),
        insertUseCase: locator(),
        updateUseCase: locator(),
      ));
  locator.registerFactory<GetAssignmentsBloc>(() => GetAssignmentsBloc(
        getAssignmentsUseCase: locator(),
      ));
  locator.registerFactory<UploadSubmissionBloc>(() => UploadSubmissionBloc(
        getSubmissionFileUseCase: locator(),
        uploadSubmissionUseCase: locator(),
      ));
  locator.registerFactory<GetSubmissionsBloc>(() => GetSubmissionsBloc(
        getSubmissionsUseCase: locator(),
      ));
  locator.registerFactory<GetSubmittedAssignmentsBloc>(
      () => GetSubmittedAssignmentsBloc(
            getSubmittedAssignmentsUseCase: locator(),
          ));
  locator.registerFactory<GetUnsubmittedAssignmentsBloc>(
      () => GetUnsubmittedAssignmentsBloc(
            getUnsubmittedAssignmentsUseCase: locator(),
          ));
  locator.registerFactory<GetAttendancesBloc>(() => GetAttendancesBloc(
        getAttendancesUseCase: locator(),
      ));
  locator.registerFactory<AttendanceCloudBloc>(() => AttendanceCloudBloc(
        insertUseCase: locator(),
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
  locator.registerLazySingleton<JoinClassUseCase>(
      () => JoinClassUseCase(locator()));
  locator.registerLazySingleton<GetEnrolledClassesByIdUseCase>(
      () => GetEnrolledClassesByIdUseCase(locator()));
  locator.registerLazySingleton<GetClassTeacherUseCase>(
      () => GetClassTeacherUseCase(locator()));
  locator.registerLazySingleton<GetClassStudentsUseCase>(
      () => GetClassStudentsUseCase(locator()));
  locator.registerLazySingleton<InsertAnnouncementUseCase>(
      () => InsertAnnouncementUseCase(locator()));
  locator.registerLazySingleton<UpdateAnnouncementUseCase>(
      () => UpdateAnnouncementUseCase(locator()));
  locator.registerLazySingleton<DeleteAnnouncementUseCase>(
      () => DeleteAnnouncementUseCase(locator()));
  locator.registerLazySingleton<GetAnnouncementsByClassUseCase>(
      () => GetAnnouncementsByClassUseCase(locator()));
  locator.registerLazySingleton<InsertAssignmentUseCase>(
      () => InsertAssignmentUseCase(locator()));
  locator.registerLazySingleton<UpdateAssignmentUseCase>(
      () => UpdateAssignmentUseCase(locator()));
  locator.registerLazySingleton<DeleteAssignmentUseCase>(
      () => DeleteAssignmentUseCase(locator()));
  locator.registerLazySingleton<GetAssignmentsByClassUseCase>(
      () => GetAssignmentsByClassUseCase(locator()));
  locator.registerLazySingleton<GetSubmissionFileUseCase>(
      () => GetSubmissionFileUseCase(locator()));
  locator.registerLazySingleton<GetSubmissionStatusUseCase>(
      () => GetSubmissionStatusUseCase(locator()));
  locator.registerLazySingleton<UploadSubmissionUseCase>(
      () => UploadSubmissionUseCase(locator()));
  locator.registerLazySingleton<GetSubmittedAssignmentsUseCase>(
      () => GetSubmittedAssignmentsUseCase(locator()));
  locator.registerLazySingleton<GetUnsubmittedAssignmentsUseCase>(
      () => GetUnsubmittedAssignmentsUseCase(locator()));
  locator.registerLazySingleton<GetAttendancesByClassUseCase>(
      () => GetAttendancesByClassUseCase(locator()));
  locator.registerLazySingleton<InsertAttendanceUseCase>(
      () => InsertAttendanceUseCase(locator()));

  // Repository
  locator.registerLazySingleton<FirebaseAuthRepository>(
      () => FirebaseAuthRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<FirebaseUserCloudRepository>(
      () => FirebaseUserCloudRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<FirebaseClassCloudRepository>(
      () => FirebaseClassCloudRepositoryImpl(locator()));
  locator.registerLazySingleton<FirebaseAnnouncementCloudRepository>(() =>
      FirebaseAnnouncementCloudRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<FirebaseAssignmentCloudRepository>(
      () => FirebaseAssignmentCloudRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<FirebaseAttendanceCloudRepository>(
      () => FirebaseAttendanceCloudRepositoryImpl(remoteDataSource: locator()));

  // Data source
  locator.registerLazySingleton<FirebaseAuthRemote>(
      () => FirebaseAuthRemoteImpl());
  locator.registerLazySingleton<FirebaseUserCloudRemote>(
      () => FirebaseUserCloudRemoteImpl());
  locator.registerLazySingleton<FirebaseClassCloudRemote>(
      () => FirebaseClassCloudRemoteImpl());
  locator.registerLazySingleton<FirebaseAnnouncementCloudRemote>(
      () => FirebaseAnnouncementCloudRemoteImpl());
  locator.registerLazySingleton<FirebaseAssignmentCloudRemote>(
      () => FirebaseAssignmentCloudRemoteImpl());
  locator.registerLazySingleton<FirebaseAttendanceCloudRemote>(
      () => FirebaseAttendanceCloudRemoteImpl());

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
  locator.registerLazySingleton<SwitchThemeProvider>(
      () => SwitchThemeProvider(locator()));
}
