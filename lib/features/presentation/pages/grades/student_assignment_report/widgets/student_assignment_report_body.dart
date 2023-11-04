import 'package:final_project/common/extensions/strings.dart';
import 'package:final_project/common/util/date_util.dart';
import 'package:final_project/features/domain/entities/grade/grade_content.dart';
import 'package:flutter/material.dart';

class StudentAssignmentReportBody extends StatelessWidget {
  const StudentAssignmentReportBody({
    super.key,
    required this.theme, required this.data,
  });

  final ThemeData theme;
  final AssignmentDetail data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.assignmentName,
          style: theme.textTheme.titleLarge,
        ),
        Text(
          "Submitted at ${DateUtil.formatDate(data.submittedDate)}",
          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
        ),
        const Divider(),
        Card(
          child: ListTile(
            onTap: () => print,
            leading: const Icon(Icons.attach_file),
            title: Text(
              "${"Filename".truncateTo(10)} .pdf",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.download),
          ),
        )
      ],
    );
  }
}
