import 'package:final_project/features/presentation/pages/grades/class_report/class_report_page.dart';
import 'package:flutter/material.dart';

class FinalGradeList extends StatelessWidget {
  final bool shouldLimit;

  const FinalGradeList({
    super.key,
    required this.shouldLimit,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: shouldLimit ? 3 : 7,
      itemBuilder: (context, index) {
        return const _FinalGradeItem();
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
    );
  }
}

class _FinalGradeItem extends StatelessWidget {
  const _FinalGradeItem();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, ClassReportPage.route),
        leading: const Icon(Icons.star),
        title: const Text('Class 1 Report'),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
