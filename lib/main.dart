import 'package:final_project/common/util/switch_theme_util.dart';
import 'package:final_project/common/util/theme.dart';
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
import 'package:final_project/features/presentation/bloc/attendance_cloud/get_attendance_status/get_attendance_status_bloc.dart';
import 'package:final_project/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/presentation/bloc/class_cloud/class_cloud_bloc.dart';
import 'package:final_project/features/presentation/bloc/class_cloud/class_index/class_index_bloc.dart';
import 'package:final_project/features/presentation/bloc/class_cloud/get_class_students/get_class_students_bloc.dart';
import 'package:final_project/features/presentation/bloc/class_cloud/get_class_teacher/get_class_teacher_bloc.dart';
import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/splash/splash_page.dart';
import 'package:final_project/firebase_options.dart';
import 'package:final_project/injection.dart' as di;
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart';
import 'package:final_project/features/presentation/route.dart' as route;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MainApp());
}

class MainApp extends StatelessWidget with WidgetsBindingObserver {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => di.locator<AuthBloc>()),
        BlocProvider<UserCloudBloc>(
            create: (context) => di.locator<UserCloudBloc>()),
        BlocProvider<ClassCloudBloc>(
            create: (context) => di.locator<ClassCloudBloc>()),
        BlocProvider<ClassIndexBloc>(
            create: (context) => di.locator<ClassIndexBloc>()),
        BlocProvider<GetClassTeacherBloc>(
            create: (context) => di.locator<GetClassTeacherBloc>()),
        BlocProvider<GetClassStudentsBloc>(
            create: (context) => di.locator<GetClassStudentsBloc>()),
        BlocProvider<AnnouncementCloudBloc>(
            create: (context) => di.locator<AnnouncementCloudBloc>()),
        BlocProvider<GetAnnouncementsBloc>(
            create: (context) => di.locator<GetAnnouncementsBloc>()),
        BlocProvider<AssignmentCloudBloc>(
            create: (context) => di.locator<AssignmentCloudBloc>()),
        BlocProvider<GetAssignmentsBloc>(
            create: (context) => di.locator<GetAssignmentsBloc>()),
        BlocProvider<GetSubmissionsBloc>(
            create: (context) => di.locator<GetSubmissionsBloc>()),
        BlocProvider<UploadSubmissionBloc>(
            create: (context) => di.locator<UploadSubmissionBloc>()),
        BlocProvider<GetSubmittedAssignmentsBloc>(
            create: (context) => di.locator<GetSubmittedAssignmentsBloc>()),
        BlocProvider<GetUnsubmittedAssignmentsBloc>(
            create: (context) => di.locator<GetUnsubmittedAssignmentsBloc>()),
        BlocProvider<GetAttendancesBloc>(
            create: (context) => di.locator<GetAttendancesBloc>()),
        BlocProvider<AttendanceCloudBloc>(
            create: (context) => di.locator<AttendanceCloudBloc>()),
        BlocProvider<GetAttendanceStatusBloc>(
            create: (context) => di.locator<GetAttendanceStatusBloc>()),
      ],
      child: ChangeNotifierProvider(
        create: (_) => di.locator<SwitchThemeProvider>(),
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeUtil.lightTheme,
            darkTheme: ThemeUtil.darkTheme,
            themeMode: context.watch<SwitchThemeProvider>().themeMode,
            onGenerateRoute: route.controller,
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
