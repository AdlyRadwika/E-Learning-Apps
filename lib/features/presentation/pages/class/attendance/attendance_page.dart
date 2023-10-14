import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/class/attendance/widgets/attendance_item.dart';
import 'package:final_project/features/presentation/pages/class/attendance/widgets/student_attendance_item.dart';
import 'package:final_project/features/presentation/pages/face_recognition/face_recognitionv2_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendancePage extends StatelessWidget {
  static const route = '/class-attendance';

  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class 1 Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: BlocBuilder<UserCloudBloc, UserCloudState>(
            builder: (context, state) {
          return ListView.separated(
            itemBuilder: (context, index) {
              if (state is GetUserByIdResult && state.isSuccess) {
                final data = state.user;
                if (data?.role == 'teacher') {
                  return const StudentAttendanceItem();
                }
              }
              return const AttendanceItem();
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: 3,
          );
        }),
      ),
      floatingActionButton:
          BlocBuilder<UserCloudBloc, UserCloudState>(builder: (context, state) {
        if (state is GetUserByIdResult && state.isSuccess) {
          final data = state.user;
          if (data?.role == 'teacher') {
            return const SizedBox.shrink();
          }
        }
        return FloatingActionButton(
          onPressed: () => Navigator.pushNamed(
              context, FaceRecognitionV2Page.route,
              arguments: {
                "isAttendance": true,
                "isUpdate": false,
              }),
          child: const Icon(Icons.camera_alt),
        );
      }),
    );
  }
}
