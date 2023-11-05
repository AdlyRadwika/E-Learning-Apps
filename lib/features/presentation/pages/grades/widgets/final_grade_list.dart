import 'package:final_project/features/domain/entities/class/class.dart';
import 'package:final_project/features/domain/entities/class/enrolled_class.dart';
import 'package:final_project/features/presentation/pages/grades/class_report/class_report_page.dart';
import 'package:final_project/features/presentation/pages/grades/student_report/student_report_page.dart';
import 'package:flutter/material.dart';

class FinalGradeList extends StatelessWidget {
  final List<Class>? classes;
  final List<EnrolledClass>? enrolledClasses;

  const FinalGradeList({
    super.key,
    required this.classes,
    required this.enrolledClasses,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: classes?.length ?? enrolledClasses?.length ?? 0,
      itemBuilder: (context, index) {
        if (classes?.isNotEmpty == true) {
          final data = classes?[index];
          return _TeacherGradeItem(data);
        } else {
          final data = enrolledClasses?[index];
          return _StudentGradeItem(data);
        }
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
    );
  }
}

class _TeacherGradeItem extends StatelessWidget {
  final Class? data;

  const _TeacherGradeItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, ClassReportPage.route,
            arguments: {
              'classCode': data?.code ?? '-',
              'className': data?.title ?? '-'
            }),
        leading: const Icon(Icons.star),
        title: Text('${data?.title ?? "Unknown"} Report'),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

class _StudentGradeItem extends StatelessWidget {
  final EnrolledClass? data;

  const _StudentGradeItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () =>
            Navigator.pushNamed(context, StudentReportPage.route, arguments: {
          'classCode': data?.code ?? '-',
          'studentId': data?.studentId ?? '-',
          'studentName': '-',
          'className': data?.title ?? '-',
        }),
        leading: const Icon(Icons.star),
        title: Text('${data?.title ?? "Unknown"} Report'),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
