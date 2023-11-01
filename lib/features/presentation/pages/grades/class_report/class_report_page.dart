import 'package:final_project/features/presentation/pages/grades/class_report/widgets/student_report_list.dart';
import 'package:flutter/material.dart';

class ClassReportPage extends StatelessWidget {
  static const route = '/class-report';

  const ClassReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Class 1's Report"),
        actions: [
          IconButton(
              tooltip: 'Download',
              onPressed: () => print,
              icon: const Icon(Icons.download))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                'Students',
                style: theme.textTheme.titleLarge,
              ),
            ),
            const StudentReportList()
          ],
        ),
      ),
    );
  }
}
