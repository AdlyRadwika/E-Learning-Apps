import 'package:final_project/common/extensions/snackbar.dart';
import 'package:final_project/common/extensions/strings.dart';
import 'package:final_project/common/util/date_util.dart';
import 'package:final_project/features/domain/entities/grade/grade_content.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentAssignmentReportBody extends StatelessWidget {
  const StudentAssignmentReportBody({
    super.key,
    required this.theme,
    required this.data,
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
            onTap: () async {
              final uri = Uri.tryParse(data.fileUrl);
              if (await canLaunchUrl(uri!)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              } else {
                if (context.mounted) {
                  context.showErrorSnackBar(context,
                      message: "Your submission file couldn't be opened.");
                }
              }
            },
            leading: const Icon(Icons.attach_file),
            title: Text(
              "${data.fileName.truncateTo(10)} .pdf",
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
