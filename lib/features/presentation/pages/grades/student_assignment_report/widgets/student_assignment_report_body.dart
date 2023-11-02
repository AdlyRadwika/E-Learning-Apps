
import 'package:final_project/common/extensions/strings.dart';
import 'package:final_project/common/util/date_util.dart';
import 'package:flutter/material.dart';

class StudentAssignmentReportBody extends StatelessWidget {
  const StudentAssignmentReportBody({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Assignment 1",
          style: theme.textTheme.titleLarge,
        ),
        Text(
          "Submitted at ${DateUtil.formatDate(DateTime.now().toString())}",
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
            subtitle: const Text("1 MB"),
            trailing: const Icon(Icons.download),
          ),
        )
      ],
    );
  }
}
