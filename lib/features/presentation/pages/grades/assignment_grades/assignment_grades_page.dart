import 'package:final_project/features/presentation/pages/grades/widgets/assignment_grade_list.dart';
import 'package:flutter/material.dart';

class AssignmentGradesPage extends StatelessWidget {
  static const route = '/assignment-grades';

  const AssignmentGradesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assignment Grades')),
      body: const CustomScrollView(
        slivers: [
          AssignmentGradeList(shouldLimit: false)
        ],
      ),
    );
  }
}
