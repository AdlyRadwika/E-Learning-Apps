import 'package:final_project/features/presentation/pages/class/attendance/widgets/attendance_item.dart';
import 'package:final_project/features/presentation/pages/face_recognition/face_recognitionv2_page.dart';
import 'package:flutter/material.dart';

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
        child: ListView.separated(
          itemBuilder: (context, index) {
            return const AttendanceItem();
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount: 3,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
            context, FaceRecognitionV2Page.route,
            arguments: {
              "isAttendance": true,
              "isUpdate": false,
            }),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
