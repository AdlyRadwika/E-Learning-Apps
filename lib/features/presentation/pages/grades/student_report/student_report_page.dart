import 'package:final_project/features/presentation/pages/grades/student_report/widgets/student_assignments_content.dart';
import 'package:final_project/features/presentation/pages/grades/student_report/widgets/student_final_grade.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class StudentReportPage extends StatelessWidget {
  static const route = '/student-report';

  const StudentReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student 1's Report"),
        actions: [
          IconButton(
              onPressed: () => print,
              tooltip: 'Download',
              icon: const Icon(Icons.download))
        ],
      ),
      body: SlidingUpPanel(
        color: theme.colorScheme.background,
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 10.0,
        ),
        minHeight: 60,
        maxHeight: 140,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        panelBuilder: () => StudentFinalGrade(theme: theme),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: StudentAssignmentContent(theme: theme),
        ),
      ),
    );
  }
}
