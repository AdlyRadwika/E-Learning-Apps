import 'package:final_project/common/util/date_util.dart';
import 'package:final_project/features/domain/entities/grade/grade_content.dart';
import 'package:final_project/features/presentation/pages/grades/student_assignment_report/student_assignment_report_page.dart';
import 'package:flutter/material.dart';

class StudentAssignmentItem extends StatelessWidget {
  final bool showStudentName;
  final AssignmentDetail? data;
  final ThemeData theme;
  final GradeContentOwner? user;
  final String classCode;

  const StudentAssignmentItem({
    super.key,
    required this.theme,
    required this.showStudentName,
    required this.data,
    required this.user,
    required this.classCode,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.pushNamed(
            context, StudentAssignmentReportPage.route,
            arguments: {
              'data': data,
              'studentId': user?.uid ?? '-',
              'classCode': classCode,
            }),
        leading: const Icon(Icons.assignment_ind_outlined),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              showStudentName
                  ? user?.name ?? "Someone"
                  : data?.assignmentName ?? "Unknown",
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
              child: Text(DateUtil.formatDate(
                  data?.submittedDate ?? DateTime.now().toString())),
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
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
