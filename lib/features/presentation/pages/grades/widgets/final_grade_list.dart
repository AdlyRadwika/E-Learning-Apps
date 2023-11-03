import 'package:final_project/common/util/user_config.dart';
import 'package:final_project/features/presentation/pages/grades/class_report/class_report_page.dart';
import 'package:final_project/features/presentation/pages/grades/student_report/student_report_page.dart';
import 'package:flutter/material.dart';

class FinalGradeList extends StatelessWidget {
  const FinalGradeList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: 7,
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
        onTap: () {
          UserConfigUtil.role == 'teacher'
              ? Navigator.pushNamed(context, ClassReportPage.route)
              : Navigator.pushNamed(context, StudentReportPage.route);
        },
        leading: const Icon(Icons.star),
        title: const Text('Class 1 Report'),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
