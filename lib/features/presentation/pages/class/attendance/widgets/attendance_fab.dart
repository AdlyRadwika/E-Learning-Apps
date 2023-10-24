import 'package:final_project/common/util/user_config.dart';
import 'package:final_project/features/domain/entities/attendance/attendance.dart';
import 'package:final_project/features/presentation/bloc/attendance_cloud/get_attendance_status/get_attendance_status_bloc.dart';
import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/features/presentation/pages/face_recognition/face_recognitionv2_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceFAB extends StatelessWidget {
  const AttendanceFAB({
    super.key,
    required this.classCode,
  });

  final String classCode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCloudBloc, UserCloudState>(
        builder: (context, state) {
      if (state is GetUserByIdResult && state.isSuccess) {
        final data = state.user;
        if (data?.role == 'teacher') {
          return const SizedBox.shrink();
        }
      }
      return BlocBuilder<GetAttendanceStatusBloc, GetAttendanceStatusState>(
          builder: (context, state) {
        if (state is GetAttendanceStatusByStudentLoading) {
          return const FloatingActionButton(
            onPressed: null,
            child: CircularProgressIndicator(),
          );
        }
        if (state is GetAttendanceStatusByStudentResult && !state.isSuccess) {
          return FloatingActionButton.extended(
            onPressed: () => context.read<GetAttendanceStatusBloc>().add(
                GetAttendanceStatusByStudentEvent(
                    classCode: classCode, studentId: UserConfigUtil.uid)),
            label: const Text('Try Again'),
          );
        }
        if (state is GetAttendanceStatusByStudentResult && state.isSuccess) {
          return StreamBuilder(
              stream: state.statusStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return FloatingActionButton.extended(
                    onPressed: () => context
                        .read<GetAttendanceStatusBloc>()
                        .add(GetAttendanceStatusByStudentEvent(
                            classCode: classCode,
                            studentId: UserConfigUtil.uid)),
                    label: const Text('Try Again'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const FloatingActionButton(
                    onPressed: null,
                    child: CircularProgressIndicator(),
                  );
                }

                final docs = snapshot.data?.docs;
                final data =
                    docs?.map((item) => item.data().toEntity()).firstWhere(
                          (element) => DateTime.parse(element.createdAt)
                              .isBefore(DateTime.now()),
                          orElse: () => const Attendance(
                              id: '-',
                              label: '-',
                              studentId: '-',
                              updatedAt: '-',
                              createdAt: '-',
                              classCode: '-'),
                        );

                if (data == null || data.id == '-') {
                  return FloatingActionButton(
                    onPressed: () => Navigator.pushNamed(
                        context, FaceRecognitionV2Page.route,
                        arguments: {
                          "classCode": classCode,
                          "isAttendance": true,
                          "isUpdate": false,
                        }),
                    child: const Icon(Icons.camera_alt),
                  );
                } else {
                  return const FloatingActionButton.extended(
                      onPressed: null, label: Text('You have attend today'));
                }
              });
        }
        return const SizedBox.shrink();
      });
    });
  }
}
