import 'package:final_project/features/presentation/pages/grades/student_report/student_report_page.dart';
import 'package:flutter/material.dart';

class StudentReportList extends StatelessWidget {
  const StudentReportList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: 9,
      itemBuilder: (context, index) {
        return const _StudentReportItem();
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
    );
  }
}

class _StudentReportItem extends StatelessWidget {
  const _StudentReportItem();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, StudentReportPage.route),
        leading: const Icon(Icons.person),
        title: const Text('Student 1'),
        trailing: const Icon(Icons.edit),
      ),
    );
  }
}
