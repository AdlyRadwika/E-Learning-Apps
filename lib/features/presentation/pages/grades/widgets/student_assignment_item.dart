import 'package:final_project/common/util/date_util.dart';
import 'package:final_project/features/domain/entities/grade/grade_content.dart';
import 'package:final_project/features/presentation/pages/grades/student_assignment_report/student_assignment_report_page.dart';
import 'package:flutter/material.dart';

class StudentAssignmentItem extends StatelessWidget {
  final bool showStudentName;
  final AssignmentDetail? data;
  final ThemeData theme;

  const StudentAssignmentItem({
    super.key,
    required this.theme,
    required this.showStudentName,
    required this.data,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () =>
            Navigator.pushNamed(context, StudentAssignmentReportPage.route, arguments: {
              'data': data,
            }),
        leading: const Icon(Icons.assignment_ind_outlined),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              showStudentName ? "Student 1" : 'Assignment 1',
              overflow: TextOverflow.ellipsis,
            )),
            const Expanded(
                child: Text(
              'Score',
              textAlign: TextAlign.end,
            )),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(DateUtil.formatDate(DateTime.now().toString())),
            ),
            Expanded(
              child: Text(
                '${data?.grade ?? 0}',
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
